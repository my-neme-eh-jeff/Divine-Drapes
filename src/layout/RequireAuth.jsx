/* eslint-disable react/prop-types */
import { useLocation, Navigate, Outlet } from "react-router-dom";
import useAuth from "../Hooks/useAuth";
import jwt_decode from "jwt-decode";

const RequireAuth = ({ allowedRoles }) => {
  const { auth } = useAuth();
  const location = useLocation();

  const decoded = auth?.accessToken ? jwt_decode(auth.accessToken) : undefined;
  console.log(decoded);

  const roles = decoded?.UserInfo.roles || [];

  return roles
    .filter(Boolean)
    .find((role) => allowedRoles?.includes(role.toString())) ? (
    <Outlet />
  ) : auth?.accessToken ? (
    <Navigate to="/" />
  ) : (
    <Navigate to="/login" state={{ from: location }} replace />
  );
};

export default RequireAuth;
