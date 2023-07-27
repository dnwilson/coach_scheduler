import './App.css'
import { AppContext } from "./AppContext"
import { CoachList, CoachNew, CoachShow } from "./components/CoachList"
import { StudentList, StudentShow } from "./components/Students"
import { useState } from 'react'
import { Routes, Route, Link } from 'react-router-dom'

function App() { 
  const [coach, setCoach] = useState();
  const [coaches, setCoaches] = useState([]);
  const [student, setStudent] = useState();
  const [currentUser, setCurrentUser] = useState({});
  const [students, setStudents] = useState([]);

  const Home = () => {
    return(
      <div className="home">
        <h1>CoachScheduler</h1>
        <div className="user-type">
          <Link to="/coaches" className="button">
            I am a Coach
          </Link>
          <Link to="/students" className="button">
            I am a Student
          </Link>
        </div>
      </div>
    )
  }

  return (
    <AppContext.Provider value={{
      coach, setCoach, coaches, setCoaches, student, setStudent,
      students, setStudents, currentUser, setCurrentUser
      }}>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/coaches" element={<CoachList />} />
        <Route path="/coaches/:id" element={<CoachShow />} />
        <Route path="/students" element={<StudentList />} />
        <Route path="/students/:id" element={<StudentShow />} />
      </Routes>
    </AppContext.Provider>
  )
}

export default App
