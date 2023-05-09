import { useState } from "react";
import {
  Box,
  Button,
  FormControl,
  InputLabel,
  OutlinedInput,
  InputAdornment,
  IconButton,
  FormHelperText,
} from "@mui/material";
import { styled } from "@mui/material/styles";
import { useEffect } from "react";
import { Email, Visibility, VisibilityOff } from "@mui/icons-material";
// import { createTheme, ThemeProvider } from "@mui/material/styles";
import { Link } from "react-router-dom";
import Grid from "@mui/material/Grid";
import EmailOutlinedIcon from "@mui/icons-material/EmailOutlined";
import "./Login.css";
import { useFormik } from "formik";
import loginSide from "../images/loginSide.png";
import logo from "../images/logo.png";
import * as yup from "yup";
import LockOutlinedIcon from "@mui/icons-material/LockOutlined";
// import { makeStyles } from '@mui/material/styles';

const validationSchema = yup.object({
  email: yup
    .string("Enter your email")
    .email("Enter a valid email")
    .required("Email is required"),
  password: yup
    .string("Enter your password")
    .min(8, "Password should be of minimum 8 characters length")
    .required("Password is required"),
});

const Login = () => {
  // formik

  const formik = useFormik({
    initialValues: {
      email: "",
      password: "",
    },
    validationSchema: validationSchema,
    onSubmit: (values) => {
      alert(JSON.stringify(values, null, 2));
    },
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

  const responsiveness2 = { responsive: width < 850 };
  const resp2 = responsiveness2.responsive;

  //   const responsiveness3 = { responsive: width >= 850 && width < 900 };
  //   const resp3 = responsiveness3.responsive;
  //

  const [showPassword, setShowPassword] = useState(false);
  const handleClickShowPassword = () => setShowPassword((show) => !show);

  const LoginButton = styled(Button)({
    backgroundColor: "#A01E86",
    margin: "1rem",
    borderRadius: "0.3rem",
    marginLeft: "1.2rem",
    textDecoration: "none",
    padding: "12px 15px ",
    width: resp ? "22rem" : "28rem",
    height: "3.1875rem",
    color: "white",
    fontSize: "1rem",
    position: "relative",
    right: resp ? "" : "1.4rem",
    "&:hover": { backgroundColor: "#5E9387", color: "white" },
  });

  //   customising FormControl

  const CustomFormControl = styled(FormControl)({
    "& .MuiInput-root": {
      color: "black", // color of the input text
      "& fieldset": {
        borderColor: "black", // color of the border
        borderRadius: "10px",
      },
      "&::placeholder": {
        color: "black", // color of the placeholder text
      },
    },
  });

  const CssFormControl = styled(FormControl)({
    "& .MuiOutlinedInput-root": {
      "& input": {
        color: "black", // color of the text entered by the user
      },
    },
  });

  const EmailField = () => {
    return ( 
        <>
                      <FormControl
                style={{
                  margin:
                    formik.touched.email && formik.errors.email
                      ? "0"
                      : "0 0 1rem 0",
                  width: resp ? "40ch" : "50ch",
                  borderRadius: "10px",
                }}
                variant="outlined"
                id="email"
                name="email"
                value={formik.values.email}
                onChange={formik.handleChange}
                error={formik.touched.email && Boolean(formik.errors.email)}
                helperText={formik.touched.email && formik.errors.email}
              >
                <InputLabel htmlFor="email-input">Email</InputLabel>
                <OutlinedInput
                  id="outlined-adornment-email"
                  startAdornment={
                    <InputAdornment position="start">
                      <EmailOutlinedIcon />
                    </InputAdornment>
                  }
                  type="email"
                  label="Email"
                  placeholder="Email"
                  name="email"
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
        </>
     );
  }

  const PasswordField = () => {
    return ( 
        <>              <FormControl
        sx={{
          width: resp ? "40ch" : "50ch",
          margin: "1rem 0 0.5 0",
          borderRadius: "10px",
        }}
        variant="outlined"
        value={formik.values.password}
        onChange={formik.handleChange}
        error={
          formik.touched.password && Boolean(formik.errors.password)
        }
        helperText={formik.touched.password && formik.errors.password}
        required
      >
        <InputLabel htmlFor="outlined-adornment-password">
          Password
        </InputLabel>
        <OutlinedInput
          id="outlined-adornment-password"
          type={showPassword ? "text" : "password"}
          label="Password"
          name="password"
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
        
        </>
     );
  }



  const LoginComponet = () => {
    return (
      <Grid
        container
        spacing={0}
        className="login_main_container"
        style={{
          display: resp2 ? "flex" : "",
          justifyContent: "center",
          alignItems: "center",
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
            // border : '2px solid red',
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
                border: "2px solid black",
                display: "flex",
                flexDirection: "column",
                alignItems: resp ? "center" : "flex-start",
                padding: "1rem",
              }}
            >
                <EmailField/>
                <PasswordField/>


              <div style={{ display: "flex" }}>
                <LoginButton type="submit">Log in</LoginButton>
              </div>

              <div style={{}}>
                <span style={{ color: "gray", margin: "0.6rem 0" }}>
                  Don't have an account?
                  <Link to="/Signup" style={{ textDecoration: "none" }}>
                    <a
                      href="/"
                      style={{
                        textDecoration: "none",
                        color: "#4A2145",
                        margin: "0 0.7rem",
                        fontWeight: "32.25rem",
                      }}
                      // onClick={changeFRegStat}
                    >
                      Sign Up
                    </a>
                  </Link>
                </span>
              </div>
            </Box>
          </form>
        </Grid>
        <Grid item xs={6} className="img1 c">
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
        </Grid>
      </Grid>
    );
  };

  return <>{LoginComponet()}</>;
};

export default Login;
