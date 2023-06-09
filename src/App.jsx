import './App.css'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Login from './layout/Login'
import Signup from './layout/Signup'
import Footer from './layout/Footer/Footer'
import Profile from './layout/Profile'
import Product from './layout/product/Product'
import Buy from './layout/product/Buy'

function App() {

  return (
    <>
    <div className='App'>
      <Router>
        <Routes>
          <Route path='/' element={<> <Login/> </>}></Route>
          <Route path='/signup' element={<> <Signup/> </>}></Route>
        </Routes>
        <Routes>
          <Route path='/footer' element={<> <Footer/> </>}></Route>
        </Routes>
        <Routes>
          <Route path='/profile' element={<><Profile/></>}></Route>
        </Routes>
        <Routes>
          <Route path='/product' element={<><Product/></>}></Route>
        </Routes>
        <Routes>
          <Route path='/buy' element={<><Buy/></>}></Route>
        </Routes>
      </Router>
    </div>
    </>
    )
}

export default App
