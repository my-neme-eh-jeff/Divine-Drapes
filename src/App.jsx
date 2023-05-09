import './App.css'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Login from './layout/Login'
import Footer from './layout/Footer/Footer'

function App() {

  return (
    <>
    <div className='App'>
      <Router>
        <Routes>
          <Route path='/' element={<> <Login/> </>}></Route>
        </Routes>
        <Routes>
          <Route path='/footer' element={<> <Footer/> </>}></Route>
        </Routes>
      </Router>
    </div>
    </>
    )
}

export default App
