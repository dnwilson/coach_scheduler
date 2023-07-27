import "./Slots.css"
import { get, post } from "../services/api"
import { AppContext } from "../AppContext";
import { useContext, useState, useRef } from "react";
import { Link, useParams, useNavigate } from "react-router-dom";
import ModalForm from "./ModalForm";
import { List } from "./List";

const Slot = ({ slot, link }) => {
  const [currentSlot, setCurrentSlot] = useState(slot)
  const { currentUser } = useContext(AppContext)

  const submitToAPI = () => {
    post("appointments", {
      slot_id: currentSlot.id,
      student_id: currentUser.id
    })
      .then((response) => response.data)
      .then((data) => {
        setCurrentSlot({})
        console.log("Data", data)
      })
      .catch((error) => console.error(error));
  }

  const classNames = () => {
    return `slot ${link ? "link" : ""} ${currentSlot.slot_id ? "filled" : "open"}`
  }

  return(
    <>
      {
        slot &&
          link
            ? <a className={classNames()} onClick={submitToAPI}>{currentSlot.formatted_time}</a>
            : <div className={classNames()}>{currentSlot.formatted_time}</div>
      }
    </>
  )
}

const SlotForm = ({ coach, close }) => {
  const dateInput = useRef()
  const { setCoach } = useContext(AppContext);

  const handleSubmit = (event) => {
    event.preventDefault();
    const data = new FormData();

    data.append("slot[coach_id]", coach.id);
    data.append("slot[start_at]", dateInput.current.value);
    submitToAPI(data);
  }

  const submitToAPI = (data) => {
    post("slots", data)
      .then((response) => response.data)
      .then((data) => {
        setCoach(data.coach)
        close()
      })
      .catch((error) => {
        console.error(error)
        dateInput.current.value = ""
      });
  }

  return(
    <form onSubmit={(e) => handleSubmit(e)}>
      <label htmlFor="start_at">Start at</label>
      <input type="datetime-local" ref={dateInput} name="start_at" id="start_at" step="600" />
      <div className="actions">
        <button onClick={() => close()} type="button" className='button flat'>Cancel</button>
        <button type="submit" className='button d-block'>Create Slot</button>
      </div>
    </form>
  )
}

const SlotList = ({coach, title}) => {
  title = title || "Available Slots"
  const [modal, setModal] = useState(false)

  const toggle = () => {
    setModal(!modal)
  }

  return(
    <List items={coach.slots?.map(slot => <Slot key={slot.id} slot={slot} />) }
      title={title}>
      <ModalForm url="/slots" title="Slot" show={modal} toggle={toggle}>
        <SlotForm coach={coach} close={toggle} />
      </ModalForm>
    </List>
  )
}

export { SlotList, SlotForm, Slot }