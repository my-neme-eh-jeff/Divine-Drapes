import "./App.css";
import {
  createBrowserRouter,
  Route,
  createRoutesFromElements,
  RouterProvider,
} from "react-router-dom";
import { disableReactDevTools } from "@fvilers/disable-react-devtools";
import Login from "./layout/Login";
import Signup from "./layout/Signup";
import Profile from "./layout/Profile";
import Forgotpass from "./layout/Forgotpass";
import OTPverify from "./layout/OTPverify";
import Product from "./layout/product/Product";
import Home from "./layout/Home/Home";
import BulkOrder from "./layout/BulkOrder/BulkOrder";
import Buy from "./layout/product/Buy";
import Myorders from "./layout/Myorders";
import Myfav from "./layout/Myfav";
import ErrorPage from "./layout/ErrorPage";
import Allorders from "./layout/admin/Allorders";
import ViewOrders from "./layout/admin/ViewOrders";
import RequireAuth from "./layout/RequireAuth";
import PersistLogin from "./layout/PersistLogin";
import CheckAuth from "./layout/CheckAuth";

// * Everyone has a user role by default, But only admin has admin roles along with user role
// * agar naya protected page bana rhe ho toh osko bas wrap kardena role ke hisab se

const router = createBrowserRouter(
  createRoutesFromElements(
    <>
      <Route element={<PersistLogin />}>
      <Route element={<CheckAuth />}>
        <Route path="/login" element={<Login />} />
        <Route path="/signup" element={<Signup />} />
        <Route path="/forgotpass" element={<Forgotpass />} />
        <Route path="/otpverify" element={<OTPverify/>} />
      </Route>

        <Route
          element={
            <RequireAuth allowedRoles={[import.meta.env.VITE_USER_ROLE]} />
          }
        >
          <Route path='/' index element={<Home/>} />
          <Route path="/profile" element={<Profile />} />
          <Route path="/product" element={<Product />} />
          <Route path="/bulkorder" element={<BulkOrder />} />
          <Route path="/buy" element={<Buy />} />
          <Route path="/order" element={<Myorders />} />
          <Route path="/fav" element={<Myfav />} />
        </Route>

        <Route
          element={
            <RequireAuth allowedRoles={[import.meta.env.VITE_ADMIN_ROLE]} />
          }
        >
          <Route path="/admin/orders" element={<Allorders />} />
          <Route path="/admin/orders/view" element={<ViewOrders />} />
        </Route>

        <Route path="*" element={<ErrorPage />} />
      </Route>
    </>
  )
);

function App() {
  if (import.meta.env.VITE_NODE_ENV === "production") {
    disableReactDevTools();
  }

  return <RouterProvider router={router} />;
}

export default App;
