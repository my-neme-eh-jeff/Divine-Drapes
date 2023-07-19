import { useState } from "react";
import {
  Box,
  Button,
  FormControl,
  OutlinedInput,
  InputAdornment,
  IconButton,
} from "@mui/material";
import { styled } from "@mui/material/styles";
import { useEffect } from "react";
import { Visibility, VisibilityOff } from "@mui/icons-material";
import {  useNavigate } from "react-router-dom";
import Grid from "@mui/material/Grid";
import "./Login.css";
import { useFormik } from "formik";
import loginSide from "../images/loginSide.png";
import logo from "../images/logo.png";
import * as yup from "yup";
import React from "react";

const validationschema = yup.object({
  password: yup
    .string("Enter your password")
    .min(8, "Password should be of minimum 8 characters length")
    .required("Password is required"),
  confirmPassword: yup
    .string("Confirm Password")
    .oneOf([yup.ref("password"), null], "Passwords must match")
    .required("Password is required"),
});

const ResetPassword = () => {

  let navigate = useNavigate();

  const formik = useFormik({
    initialValues: {
      password: "",
      confirmPassword: "",
    },
    onSubmit: async (values) => {
      alert(JSON.stringify(values, null, 2));
      navigate("/login");
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

  const [showCPassword, setShowCPassword] = useState(false);
  const handleClickShowCPassword = () => setShowCPassword((show) => !show);

  const ConfirmBtn = styled(Button)({
    backgroundColor: "#A01E86",
    margin: "1rem",
    borderRadius: "0.7rem",
    marginLeft: "1.2rem",
    textDecoration: "none",
    padding: "12px 15px ",
    width: resp3 ? "37ch" : resp ? "40ch" : "45ch",
    height: "3.1875rem",
    color: "white",
    fontSize: "1rem",
    position: "relative",
    border: "2px solid black",
    "&:hover": { backgroundColor: "#b945a2", color: "white" },
  });

  const PasswordField = () => {
    return (
      <React.Fragment>
        <div
          style={{
            position:
              formik.touched.password && formik.errors.password
                ? "relative"
                : "",
          }}
        >
          <FormControl
            sx={{
              margin: "0.5rem 0 1rem 1rem",
              width: resp3 ? "37ch" : resp ? "40ch" : "45ch",
              border: "2px solid black",
              borderRadius: "0.7rem",
            }}
            variant="outlined"
            onChange={formik.handleChange}
            error={formik.touched.password && Boolean(formik.errors.password)}
            helperText={formik.touched.password && formik.errors.password}
            required
          >
            <OutlinedInput
              placeholder="Password"
              id="outlined-adornment-password"
              label="Password"
              name="password"
              type={showPassword ? "text" : "password"}
              endAdornment={
                <InputAdornment position="end">
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
                margin: "-0.7rem 0 1rem 1.2rem",
                fontSize: "0.9rem",
                // width: resp ? "20ch" : "24ch",
              }}
            >
              {formik.errors.password}
            </div>
          ) : null}
        </div>
      </React.Fragment>
    );
  };

  const ConfirmPasswordField = () => {
    return (
      <>
        <div
          style={{
            position: "relative",
            left: resp ? "" : "1rem",
          }}
        >
          <FormControl
            sx={{
              margin: "1rem 0 ",
              width: resp3 ? "37ch" : resp ? "40ch" : "45ch",
              border: "2px solid black",
              borderRadius: "0.7rem",
            }}
            variant="outlined"
            onChange={formik.handleChange}
            error={
              formik.touched.confirmPassword &&
              Boolean(formik.errors.confirmPassword)
            }
            helperText={
              formik.touched.confirmPassword && formik.errors.confirmPassword
            }
            required
          >
            <OutlinedInput
              id="outlined-adornment-password"
              name="confirmPassword"
              placeholder="Confirm Password"
              type={showCPassword ? "text" : "password"}
              endAdornment={
                <InputAdornment position="end">
                  <IconButton
                    aria-label="toggle password visibility"
                    onClick={handleClickShowCPassword}
                    // onMouseDown={handleMouseDownPassword}
                    edge="end"
                  >
                    {showCPassword ? <VisibilityOff /> : <Visibility />}
                  </IconButton>
                </InputAdornment>
              }
            />
          </FormControl>
          {formik.touched.confirmPassword && formik.errors.confirmPassword ? (
            <div
              style={{
                color: "red",
                margin: "-0.7rem 2rem 1rem 0",
                fontSize: "0.9rem",
                alignContent: "start",
              }}
            >
              {formik.errors.confirmPassword}
            </div>
          ) : null}
        </div>
      </>
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

  const ResetPasswordComponent = () => {
    return (
      <>
        <Grid
          container
          spacing={0}
          className="login_main_container"
          style={{
            display: resp2 ? "flex" : "",
            justifyContent: "center",
            alignItems: "center",
            height: "100%",
            overflowY: "hidden",
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
                  left: "1.3rem",
                }}
              >
                {PasswordField()}
                {ConfirmPasswordField()}

                <div style={{ display: "flex", marginTop: "2rem" }}>
                  <ConfirmBtn type="submit">Update password</ConfirmBtn>
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

  return <React.Fragment>{ResetPasswordComponent()}</React.Fragment>;
};

export default ResetPassword;
