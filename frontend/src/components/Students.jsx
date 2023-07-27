import "./Students.css"
import { get, post } from "../services/api"
import { AppContext } from "../AppContext";
import { useEffect, useContext, useState, useRef } from "react";
import { Link, useParams } from "react-router-dom";
import { Slot } from "./Slots";
import { List } from "./List";
import ModalForm from "./ModalForm";

const Student = ({student}) => {
  return(
    <Link to={`/students/${student.id}`} className="student">
      {
        student.image
        ? <img src={student.image} className="img" />
        : <div className="img">{student.initial}</div>
      }
      <h3 className="student-name">{student.name}</h3>
    </Link>
  )
}

const StudentShow = () => {
  const { id } = useParams()
  const { students, currentUser, setCurrentUser } = useContext(AppContext)
  const [student, setStudent] = useState(students.find(item => item.id == id) || {})

  useEffect(() => {
    if (!currentUser.id) {
      get(`students/${id}`)
      .then((response) => response.data)
      .then((data) => {
        setStudent(data)
        setCurrentUser(data)
      })
      .catch((error) => console.error(error));
    } else {
      setCurrentUser(student)
    }
  }, [student, setStudent])

  return(
    <div className="student-page">
      <div className="student-header">
        {
          student.image
          ? <img src={student.image} className="img" />
          : <div className="img">{student.initial}</div>
        }
        <h2 className="student-name">{student.name}</h2>
      </div>
      <List items={student.slots?.map(slot => <Slot key={slot.id} slot={slot} link={true} />) }
        title="Available Slots" hideTitle={true} />
    </div>
  )
}

const StudentForm = ({ close }) => {
  const nameInput = useRef()
  const imageInput = useRef()
  const { setStudent } = useContext(AppContext);

  const handleSubmit = (event) => {
    event.preventDefault();
    const data = new FormData();

    data.append("student[name]", nameInput.current.value);
    data.append("student[image]", event.target.image.files[0]);
    submitToAPI(data);
  }

  const submitToAPI = (data) => {
    fetch("http://localhost:3000/api/v1/students", {
      method: "POST",
      body: data
    })
    .then((response) => response.data)
    .then((data) => {
      setStudent(data)
      close()
    })
    .catch((error) => {
      console.error(error)
      nameInput.current.value = ""
      imageInput.current.value = ""
    });
  }

  return(
    <form onSubmit={(e) => handleSubmit(e)}>
      <label htmlFor="name">Name</label>
      <input type="text" ref={nameInput} name="name" id="name" required />
      <label htmlFor="image">Image</label>
      <input type="file" ref={imageInput} name="image" id="image" required />
      <div className="actions">
        <button onClick={() => close()} type="button" className='button flat'>Cancel</button>
        <button type="submit" className='button d-block'>Create Student</button>
      </div>
    </form>
  )
}

const StudentList = () => {
  const [modal, setModal] = useState(false)
  const { students, setStudents } = useContext(AppContext);

  useEffect(() => {
    if (students.length == 0) {
      get("students/")
        .then((response) => response.data)
        .then((data) => {
          setStudents(data);
        })
        .catch((error) => console.error(error));
    }
  }, students)

  const toggle = () => {
    setModal(!modal)
  }

  return(
    <List items={students?.map(student => <Student key={student.id} student={student} />) }
      title="Students">
      <ModalForm url="/students" title="Student" show={modal} toggle={toggle}>
        <StudentForm close={toggle} />
      </ModalForm>
    </List>
  )
}

export { StudentList, StudentShow }