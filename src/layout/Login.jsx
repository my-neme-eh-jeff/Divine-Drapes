import { useState } from "react";
import {
  Box,
  Button,
  FormControl,
  OutlinedInput,
  InputAdornment,
  IconButton,
  FormControlLabel,
  Checkbox,
} from "@mui/material";
import { styled } from "@mui/material/styles";
import { useEffect } from "react";
import { Visibility, VisibilityOff } from "@mui/icons-material";
import { Link, useLocation, useNavigate } from "react-router-dom";
import Grid from "@mui/material/Grid";
import EmailOutlinedIcon from "@mui/icons-material/EmailOutlined";
import "./Login.css";
import { useFormik } from "formik";
import loginSide from "../images/loginSide.png";
import logo from "../images/logo.png";
import * as yup from "yup";
import LockOutlinedIcon from "@mui/icons-material/LockOutlined";
import googleIcon from "../images/googleIcon.png";
import React from "react";
import publicAxios from "../Axios/publicAxios";
import { ToastContainer } from "react-toastify";
// import { toast } from "react-toastify";
// import "react-toastify/dist/ReactToastify.css";
import useAuth from "../Hooks/useAuth";

const validationschema = yup.object({
  email: yup
    .string("Enter your email")
    .email("Enter a valid email")
    .required("Email is required"),
  password: yup.string("Enter your password").required("Password is required"),
});

const Login = () => {
  const loginWithGoogle = () => {
    // window.open(`${import.meta.env.VITE_API_ENDPOINT}/auth/google`, "_self");
  };

  const { setAuth, auth } = useAuth();
  const navigate = useNavigate();
  const location = useLocation();
  const from = location.state?.from?.pathname || "/";

  useEffect(() => {
    console.log(auth);
  }, [auth]);

  const formik = useFormik({
    initialValues: {
      email: "",
      password: "",
    },
    onSubmit: async (values) => {
      const options = {
        url: `auth/login`,
        method: "POST",
        data: { ...values },
        withCredentials: true,
      };
      try {
        const resp = await publicAxios.request(options);
        const accessToken = resp?.data?.accessToken;
        const email = values.email;
        var a = {
          email: email,
          accessToken: accessToken,
        };
        setAuth({ email, accessToken });
        //toast.success("Logged in successfully");
        navigate(from, { replace: true });
      } catch (err) {
        console.log(err);
        if (!err.response) {
          // toast.error("No server response");
        } else {
          // toast.error(`${err.message}`);
        }
      }
    },
    validationSchema: validationschema,
  });

  // adding event listener for responsiveness
  const [width, setWindowWidth] = useState(0);

  useEffect(() => {
    updateDimensions();
    window.addEventListener("resize", updateDimensions);
    return () => window.removeEventListener("resize", updateDimensions);
  }, []);

  const updateDimensions = () => {
    const width = window.innerWidth;
    setWindowWidth(width);
  };

  const responsiveness = { responsive: width < 1043 };
  const resp = responsiveness.responsive;

  const responsiveness2 = { responsive: width < 1000 };
  const resp2 = responsiveness2.responsive;

  const responsiveness3 = { responsive: width < 370 };
  const resp3 = responsiveness3.responsive;

  const [showPassword, setShowPassword] = useState(false);
  const handleClickShowPassword = () => setShowPassword((show) => !show);

  const LoginButton = styled(Button)({
    backgroundColor: "#A01E86",
    margin: "1rem",
    borderRadius: "0.7rem",
    marginLeft: "1.2rem",
    textDecoration: "none",
    padding: "12px 15px ",
    width: resp3 ? "20rem" : resp ? "22rem" : "28rem",
    height: "3.1875rem",
    color: "white",
    fontSize: "1rem",
    position: "relative",
    right: resp ? "" : "1.4rem",
    border: "2px solid black",
    "&:hover": { backgroundColor: "#b945a2", color: "white" },
  });

  const EmailField = () => {
    return (
      <React.Fragment>
        <span
          style={{
            margin: resp2 ? "7px 300px 0.5rem 0rem" : "0 0 0.5rem 1rem",
            fontWeight: 600,
          }}
        >
          Email
        </span>
        <FormControl
          style={{
            margin:
              formik.touched.email && formik.errors.email ? "0" : "0 0 1rem 0",
            width: resp3 ? "37ch" : resp ? "40ch" : "50ch",
            borderRadius: "10px",
            border: "2.3px solid #4a3c3c",
          }}
          variant="outlined"
          value={formik.values.email}
          onChange={formik.handleChange}
          error={formik.touched.email && Boolean(formik.errors.email)}
          helperText={formik.touched.email && formik.errors.email}
        >
          <OutlinedInput
            id="email"
            startAdornment={
              <InputAdornment position="start">
                <EmailOutlinedIcon />
              </InputAdornment>
            }
            type="email"
            name="email"
            label="email"
            placeholder="Email"
            required
          />
        </FormControl>
        {formik.touched.email && formik.errors.email ? (
          <div
            style={{
              color: "red",
              fontSize: "0.8rem",
              margin: "0.5rem 0 1rem 0",
            }}
          >
            {formik.errors.email}
          </div>
        ) : null}
      </React.Fragment>
    );
  };

  const PasswordField = () => {
    return (
      <React.Fragment>
        <span
          style={{
            margin: resp2 ? "7px 270px 0.5rem 0rem" : "0 0 0.5rem 1rem",
            fontWeight: 600,
          }}
        >
          Password
        </span>
        <FormControl
          sx={{
            width: resp3 ? "37ch" : resp ? "40ch" : "50ch",
            margin: "1rem 0 0.5 0",
            borderRadius: "10px",
            border: "2.3px solid #4a3c3c",
          }}
          variant="outlined"
          value={formik.values.password}
          onChange={formik.handleChange}
          error={formik.touched.password && Boolean(formik.errors.password)}
          helperText={formik.touched.password && formik.errors.password}
          required
        >
          <OutlinedInput
            id="password"
            placeholder="Password"
            name="password"
            type={showPassword ? "text" : "password"}
            label="Password"
            startAdornment={
              <InputAdornment position="start">
                <LockOutlinedIcon />
              </InputAdornment>
            }
            endAdornment={
              <InputAdornment position="start">
                <IconButton
                  aria-label="toggle password visibility"
                  onClick={handleClickShowPassword}
                  edge="end"
                >
                  {showPassword ? <VisibilityOff /> : <Visibility />}
                </IconButton>
              </InputAdornment>
            }
            required
          />
        </FormControl>
        {formik.touched.password && formik.errors.password ? (
          <div
            style={{
              color: "red",
              fontSize: "0.8rem",
              margin: "0.5rem 0 1rem 0",
            }}
          >
            {formik.errors.password}
          </div>
        ) : null}
      </React.Fragment>
    );
  };

  const ForgotPBlock = () => {
    return (
      <React.Fragment>
        <div style={{ width: resp ? "38ch" : "50ch" }}>
          <FormControlLabel control={<Checkbox />} label="Remember me" />
          <Link
            to="/forgotpass"
            style={{
              marginLeft: resp ? "4rem" : "10rem",
              color: "#AF0D0D",
            }}
          >
            Forgot password
          </Link>
        </div>
      </React.Fragment>
    );
  };

  const GLoginBlock = () => {
    return (
      <React.Fragment>
        <Button
          onClick={loginWithGoogle}
          variant="outlined"
          href="#"
          sx={{
            border: "2px solid black",
            width: resp3 ? "20rem" : resp ? "22rem" : "28rem",
            padding: "0.5rem",
            borderRadius: "0.7rem",
            margin: "1rem 0 2rem 0",
            color: "black",
            fontWeight: 400,
          }}
        >
          Login with Google{" "}
          <img
            src={googleIcon}
            alt="googleIcon"
            style={{ marginLeft: "1rem" }}
          />
        </Button>
      </React.Fragment>
    );
  };

  const GiftGridI = () => {
    return (
      <React.Fragment>
        <div
          style={{
            display: "flex",
            flexDirection: "column",
            justifyContent: "center",
            alignItems: "center",
          }}
        >
          <img src={loginSide} alt="Gift Box" />
          <span
            className="welcome"
            style={{
              color: "white",
              position: "relative",
              bottom: "23rem",
            }}
          >
            Welcome Back!!
          </span>
        </div>
      </React.Fragment>
    );
  };

  const LoginComponet = () => {
    return (
      <>
        <ToastContainer />
        <Grid
          container
          spacing={0}
          className="login_main_container"
          style={{
            display: resp2 ? "flex" : "",
            justifyContent: "center",
            alignItems: "center",
            height: "100%",
            // overflowY: "hidden",
          }}
        >
          <Grid
            item
            xs={6}
            style={{
              display: "flex",
              flexDirection: "column",
              justifyContent: "center",
              alignItems: "center",
              position: "relative",
              top: resp2 ? "6rem" : "",
            }}
          >
            <img src={logo} alt="Logo" />
            <form onSubmit={formik.handleSubmit}>
              <Box
                sx={{
                  maxWidth: "31.25rem",
                  width: "31.25rem",
                  height: "31.25rem",
                  // border: "2px solid black",
                  display: "flex",
                  flexDirection: "column",
                  alignItems: resp ? "center" : "flex-start",
                  padding: "1rem",
                  position: "relative",
                  // left: resp3 ? "" : "1.3rem",
                }}
              >
                {EmailField()}
                {PasswordField()}
                {ForgotPBlock()}

                <div style={{ display: "flex", marginTop: "2rem" }}>
                  <LoginButton type="submit">Log in</LoginButton>
                </div>

                <div style={{ display: "flex", padding: "0 1.8rem" }}>
                  <hr width={150} />{" "}
                  <span style={{ margin: "0 2rem" }}> OR</span>{" "}
                  <hr width={150} />
                </div>

                <GLoginBlock />

                <div
                  style={{
                    marginLeft: resp ? "0rem" : "5.5rem",
                  }}
                >
                  <span
                    style={{
                      fontWeight: 600,
                      // margin: "0.6rem 0"
                    }}
                  >
                    Don&apos;t have an account?
                  </span>
                  <Link
                    to="/signup"
                    style={{
                      textDecoration: "none",
                      color: "#A01E86",
                      margin: "0 0 0 0.7rem ",
                    }}
                  >
                    Sign Up
                  </Link>
                </div>
              </Box>
            </form>
          </Grid>
          <Grid item xs={6} className="img1 c">
            <GiftGridI />
          </Grid>
        </Grid>
      </>
    );
  };

  return <React.Fragment>{LoginComponet()}</React.Fragment>;
};

export default Login;
