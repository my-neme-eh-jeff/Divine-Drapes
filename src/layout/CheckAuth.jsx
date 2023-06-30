import { Navigate, Outlet } from "react-router";
import useAuth from "../Hooks/useAuth";

export default function CheckAuth() {
  const { auth } = useAuth();
  if (auth.email) {
    Navigate(-1);
  }

  return <Outlet />;
}
