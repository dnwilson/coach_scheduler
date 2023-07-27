import "./Appointment.css"
import { patch } from "../services/api"
import { EmptyState } from "./List"
import Modal from "./Modal"
import { useState, useRef } from "react"

const Appointment = ({appointment, edit}) => {
  return(
    <>
      <a className="appointment" onClick={() => edit(appointment)}>
        {
          appointment.student_image
          ? <img src={appointment.student_image} className="student-image" />
          : <div className="student-image img">{appointment.student_initials}</div>
        }
        <div className="appointment-info">
          <h5 className="student-name">{appointment.student_name}</h5>
          <small>{appointment.formatted_time}</small>
        </div>
      </a>
    </>
  )
}

const AppointmentForm = ({ appointment, close }) => {
  const scoreInput = useRef()
  const notesInput = useRef()

  const handleSubmit = (event) => {
    event.preventDefault();
    const data = new FormData();

    data.append("appointment[notes]", notesInput.current.value);
    data.append("appointment[satisfaction]", scoreInput.current.value);
    submitToAPI(data);
  }

  const submitToAPI = (form) => {
    patch(`appointments/${appointment.id}`, form)
    .then((response) => response.data)
    .then((data) => {
      close({})
    })
    .catch((error) => {
      console.error(error)
      scoreInput.current.value = ""
      scoreInput.current.value = ""
    });
  }

  return(
    <form onSubmit={(e) => handleSubmit(e)}>
      <label htmlFor="score">Satisfaction</label>
      <select ref={scoreInput}  name="score" id="score" required>
        <option value="1">1</option>
        <option value="2">2</option>
        <option value="3">3</option>
        <option value="4">4</option>
        <option value="5">5</option>
      </select>
      <label htmlFor="notes">Notes</label>
      <textarea ref={notesInput} name="notes" id="notes" required />
      <div className="actions">
        <button onClick={() => close()} type="button" className='button flat'>Cancel</button>
        <button type="submit" className='button d-block'>Complete Appointment</button>
      </div>
    </form>
  )
}


const AppointmentList = ({appointments, title}) => {
  const [modal, setModal] = useState(false)
  const [currentAppointment, setCurrentAppointment] = useState()
  const [modalTitle, setModalTitle] = useState()

  const toggle = () => {
    setModal(!modal)
  }

  const manageModal = (appointment) => {
    setCurrentAppointment(appointment)
    setModalTitle(`Appointment for ${appointment.student_name}`)
    toggle()
  }

  return(
    <section id="appointments">
      <h4 className="section-title">{title} Appointments</h4>
      <div className="appointments">
        {
          appointments?.length > 0
          ? appointments.map(appointment => <Appointment appointment={appointment} key={appointment.id} edit={() => manageModal(appointment)} />)
          : <EmptyState title={`${title} Appointments`} /> 
        }
      </div>
      <Modal toggle={toggle} show={modal} title={modalTitle}>
        { currentAppointment && <AppointmentForm appointment={currentAppointment} setAppointment={setCurrentAppointment} close={() => manageModal(currentAppointment)} />}
      </Modal>
    </section>
  )
}

export { Appointment, AppointmentList }