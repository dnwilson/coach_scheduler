import "./Coach.css"
import { get } from "../services/api"
import { AppContext } from "../AppContext";
import { useEffect, useContext, useState } from "react";
import { Link, useParams, useNavigate } from "react-router-dom";
import { SlotList } from "./Slots";

const Coach = ({coach}) => {
  return(
    <Link to={`coaches/${coach.id}`} className="coach">
      {
        coach.image
        ? <img src={coach.image} className="img" />
        : <div className="img">{coach.initial}</div>
      }
      <h3 className="coach-name">{coach.name}</h3>
    </Link>
  )
}

const CoachNew = () => {
  return(
    <>
    New Coach Here!
    </>
  )
}

const CoachShow = () => {
  const { id } = useParams()
  const { coaches } = useContext(AppContext)
  const [coach, setCoach] = useState(coaches.find(item => item.id == id) || {})

  useEffect(() => {
    if (!coach.id) {
      get(`coaches/${id}`)
      .then((response) => response.data)
      .then((data) => {
        setCoach(data);
      })
      .catch((error) => console.error(error));
    }
  }, [])

  return(
    <div className="coach-page">
      <div className="coach-header">
        {
          coach.image
          ? <img src={coach.image} className="img" />
          : <div className="img">{coach.initial}</div>
        }
        <h2 className="coach-name">{coach.name}</h2>
      </div>
      <SlotList coach={coach} />
    </div>
  )
}

const CoachList = () => {
  const { coaches, setCoaches } = useContext(AppContext);

  useEffect(() => {
    if (coaches.length == 0) {
      get("coaches/")
        .then((response) => response.data)
        .then((data) => {
          setCoaches(data);
        })
        .catch((error) => console.error(error));
    }
  }, coaches)

  return(
    <div className="coaches">
      { coaches.length == 0
        ? <div className="empty-state">No coaches</div>
        : coaches.map(coach => <Coach key={coach.id} coach={coach} />)
      }
    </div>
  )
}

export { CoachList, CoachShow, CoachNew }