import './App.css'
import { BrowserRouter as Router, Routes, Route } from 'react-router-dom'
import Login from './layout/Login'
import Signup from './layout/Signup'
import Footer from './layout/Footer/Footer'
import Profile from './layout/Profile'
import Forgotpass from './layout/Forgotpass'
import OTPverify from './layout/OTPverify'
import Product from './layout/product/Product'
import Navbar from './layout/Navbar/Navbar'
import Home from './layout/Home/Home'
import BulkOrder from './layout/BulkOrder/BulkOrder'
import Buy from './layout/product/Buy'
import Myorders from './layout/Myorders'
import Myfav from './layout/Myfav'
import Allorders from './layout/admin/Allorders'


function App() {
  
  return (
    <>
    <div className='App'>
      <Router>
        <Routes>
          <Route path='/navbar' element={<> <Navbar/> </>}></Route>
          <Route path='/' index element={<> <Home/> </>}></Route>
        </Routes>
        <Routes>
          <Route path='/login' element={<> <Login/> </>}></Route>
          <Route path='/signup' element={<> <Signup/> </>}></Route>
          <Route path='/forgotpass' element={<> <Forgotpass/> </>}></Route>
          <Route path='/otpverify' element={<> <OTPverify/> </>}></Route>
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
          <Route path='/bulkorder' element={<><BulkOrder/></>}></Route>
        </Routes>
        <Routes>
          <Route path='/buy' element={<><Buy/></>}></Route>
        </Routes>
        <Routes>
          <Route path='/order' element={<><Myorders/></>}></Route>
        </Routes>
        <Routes>
          <Route path='/fav' element={<><Myfav/></>}></Route>
        </Routes>

        <Routes>
          <Route path='/admin/orders' element={<><Allorders/></>}></Route>
        </Routes>


        {/* </Route> */}
      </Router>

    </div>
    </>
    )
}

export default App
