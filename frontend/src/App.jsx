import './App.css'
import { AppContext } from "./AppContext"
import { CoachList, CoachNew, CoachShow } from "./components/CoachList"
import { useEffect, useState } from 'react'
import { Routes, Route, Link, useLocation } from 'react-router-dom'

function App() { 
  const [coach, setCoach] = useState();
  const [coaches, setCoaches] = useState([]);
  const [page, setPage] = useState("home")

  const Home = () => {
    return(
      <div className="home">
        <h1>Welcome</h1>
        <CoachList />
      </div>
    )
  }

  return (
    <AppContext.Provider value={{coach, setCoach, coaches, setCoaches, page, setPage}}>
      <Routes>
        <Route path="/" element={<Home />} />
        <Route path="/coaches" element={<CoachList />} />
        <Route path="/coaches/new" element={<CoachNew />} />
        <Route path="/coaches/:id" element={<CoachShow />} />
      </Routes>
    </AppContext.Provider>
  )
}

export default App
