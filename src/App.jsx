import './App.css'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Login from './layout/Login'
import Signup from './layout/Signup'

function App() {

  return (
    <>
    <div className='App'>
      <Router>
        <Routes>
          <Route path='/' element={<> <Login/> </>}></Route>
          <Route path='/signup' element={<> <Signup/> </>}></Route>
        </Routes>
      </Router>
    </div>
    </>
    )
}

export default App
