import * as yup from "yup";
import { useState } from "react";
import {
  Box,
  Button,
  TextField,
  FormControl,
  OutlinedInput,
  InputAdornment,
  IconButton,
} from "@mui/material";
import { styled } from "@mui/material/styles";
import { useEffect } from "react";
import { Visibility, VisibilityOff } from "@mui/icons-material";
import { Link, useNavigate } from "react-router-dom";
import Grid from "@mui/material/Grid";
import EmailOutlinedIcon from "@mui/icons-material/EmailOutlined";
import giftbox from "../images/giftbox.png";
// import React from "react";
import "./Login.css";
import { useFormik } from "formik";
import logo from "../images/logo.png";
import React from "react";
import publicAxios from "../Axios/publicAxios";
// import { toast } from "react-toastify";
// import "react-toastify/dist/ReactToastify.css";

const phoneRegExp =
  /^((\\+[1-9]{1,4}[ \\-]*)|(\\([0-9]{2,3}\\)[ \\-]*)|([0-9]{2,4})[ \\-]*)*?[0-9]{3,4}?[ \\-]*[0-9]{3,4}?$/;

const validationSchema = yup.object({
  firstName: yup
    .string("Enter your first Name")
    .max(12, "Must be 15 characters or less")
    .required("Required"),
  lastName: yup
    .string("Enter your last Name")
    .max(20, "Must be 20 characters or less")
    .required("Required"),
  contact: yup
    .string("Enter your Contact")
    .matches(phoneRegExp, "Contact in not valid")
    .required("Required"),
  email: yup
    .string("Enter your email")
    .email("Enter a valid email")
    .required("Email is required"),
  dob: yup
    .string("Enter your Date of Birth")
    .required("Date of Birth is required"),
  password: yup
    .string("Confirm Password")
    // .oneOf([yup.ref("password"), null], "Passwords must match")
    .required("Password is required"),
});

const Signup = () => {
  // adding event listener for responsiveness
  const [width, setWindowWidth] = useState(0);
  const navigate = useNavigate();
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
  //

  const formik = useFormik({
    initialValues: {
      firstName: "",
      lastName: "",
      contact: "",
      email: "",
      dob: "",
      password: "",
    },
    validationSchema: validationSchema,
    onSubmit: async (values) => {
      const options = {
        url: `auth/signup`,
        method: "POST",
        data: {
          ...values,
          lName: values.lastName,
          fName: values.firstName,
          DOB: values.dob,
          number: values.contact,
        },
      };
      try {
        const resp = await publicAxios.request(options);
        console.log(resp);
        if (resp.data.success) {
          console.log("succcc");
          navigate("/login");
        }
      } catch (err) {
        if (!err.response) {
          console.log('132123')
        } else {
          // toast.error(`${err.message}`);
        }
      }
    },
  });

  const CreateButton = styled(Button)({
    backgroundColor: "#A01E86",
    borderRadius: "0.3rem",
    textDecoration: "none",
    padding: "12px 15px ",
    width: "27.8rem",
    height: "3.1875rem",
    color: "white",
    fontSize: "0.8rem",
    marginTop: "0.5rem",
    position: "relative",
    right: resp ? "" : "5.5rem",
    "&:hover": { backgroundColor: "#b945a2", color: "white" },
  });

  const [showPassword, setShowPassword] = useState(false);
  const handleClickShowPassword = () => setShowPassword((show) => !show);

  const GiftGridI = () => {
    return (
      <React.Fragment>
        <div
          style={{
            display: "flex",
            flexDirection: "column",
            justifyContent: "center",
            alignItems: "center",
            position: "relative",
            top: "10%",
          }}
        >
          <img src={giftbox} alt="Gift Box" />
        </div>
      </React.Fragment>
    );
  };

  const FnameField = () => {
    return (
      <React.Fragment>
        <div>
          <TextField
            id="firstName"
            required
            type="text"
            // label="FirstName"
            placeholder="First Name"
            name="firstName"
            onChange={formik.handleChange}
            error={formik.touched.firstName && Boolean(formik.errors.firstName)}
            helperText={formik.touched.firstName && formik.errors.firstName}
            style={{
              margin: "0.5rem 0 1rem 0",
              width: resp3 ? "17ch" : resp ? "20ch" : "24ch",
              border: "2px solid black",
              borderRadius: "0.7rem",
            }}
          />
        </div>
      </React.Fragment>
    );
  };

  const LnameField = () => {
    return (
      <React.Fragment>
        <div>
          <TextField
            id="lname"
            type="text"
            // label="Lastname"
            placeholder="Last Name"
            name="lastName"
            //   value={signupUser.lname}
            //   onChange={signupHandleChange}
            onChange={formik.handleChange}
            error={formik.touched.lastName && Boolean(formik.errors.lastName)}
            helperText={formik.touched.lastName && formik.errors.lastName}
            required
            style={{
              margin: "0.5rem 0 1rem 1rem",
              width: resp3 ? "17ch" : resp ? "20ch" : "24ch",
              border: "2px solid black",
              borderRadius: "0.7rem",
            }}
          />
        </div>
      </React.Fragment>
    );
  };

  const EmailField = () => {
    return (
      <React.Fragment>
        <span
          style={{
            margin: resp3
              ? "0 17rem 0 0"
              : resp2
              ? "0 0 0 -20rem"
              : "0 0 0 1rem",
            fontWeight: 500,
          }}
        >
          Email
        </span>
        <FormControl
          style={{
            margin: "0.5rem 0 1rem 0",
            width: resp3 ? "37ch" : resp ? "40ch" : "50ch",
            border: "2px solid black",
            borderRadius: "0.7rem",
          }}
          variant="outlined"
          value={formik.values.email}
          onChange={formik.handleChange}
          error={formik.touched.email && Boolean(formik.errors.email)}
          helperText={formik.touched.email && formik.errors.email}
        >
          <OutlinedInput
            id="outlined-adornment-email"
            startAdornment={
              <InputAdornment position="end">
                <EmailOutlinedIcon />
              </InputAdornment>
            }
            type="email"
            label="Email"
            placeholder="  Email"
            name="email"
            required
          />
        </FormControl>
        {formik.touched.email && formik.errors.email ? (
          <div style={{ color: "red", marginBottom: "0.5rem" }}>
            {formik.errors.email}
          </div>
        ) : null}
      </React.Fragment>
    );
  };

  const ContactField = () => {
    return (
      <React.Fragment>
        <span
          style={{
            margin: resp3
              ? "0 13rem 0 0"
              : resp2
              ? "0 0 0 -16rem"
              : "0 0 0 1rem",
            fontWeight: 500,
          }}
        >
          Phone number
        </span>
        <TextField
          id="lname"
          type="text"
          // label="Contact"
          placeholder="Contact"
          name="contact"
          onChange={formik.handleChange}
          error={formik.touched.contact && Boolean(formik.errors.contact)}
          helperText={formik.touched.contact && formik.errors.contact}
          required
          style={{
            margin: "0.5rem 0 1rem 0",
            width: resp3 ? "37ch" : resp ? "40ch" : "50ch",
            border: "2px solid black",
            borderRadius: "0.7rem",
          }}
        />
      </React.Fragment>
    );
  };

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
              width: resp3 ? "17ch" : resp ? "20ch" : "24ch",
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
                margin: "-0.7rem 2rem 1rem 0",
                fontSize: "0.9rem",
                width: resp ? "20ch" : "24ch",
              }}
            >
              {formik.errors.password}
            </div>
          ) : null}
        </div>
      </React.Fragment>
    );
  };

  const current = new Date().toISOString().split("T")[0];

  const DOBField = () => {
    return (
      <React.Fragment>
        <div>
          <TextField
            id="dob"
            required
            type="date"
            // label="dob"
            // placeholder="Date of Birth"
            name="dob"
            max={current}
            onChange={formik.handleChange}
            error={formik.touched.dob && Boolean(formik.errors.dob)}
            helperText={formik.touched.dob && formik.errors.dob}
            style={{
              margin: "0.5rem 0 1rem 0",
              width: resp3 ? "17ch" : resp ? "20ch" : "24ch",
              border: "2px solid black",
              borderRadius: "0.7rem",
            }}
          />
        </div>
      </React.Fragment>
    );
  };

  return (
    <React.Fragment>
      <Grid
        container
        spacing={0}
        className="signUp_main_container"
        style={{
          // overflow: "hidden",
          display: resp2 ? "flex" : "",
          justifyContent: "center",
          alignItems: "center",
        }}
      >
        <Grid item xs={6} className="img2 c">
          <GiftGridI />
        </Grid>
        <Grid
          item
          xs={6}
          style={{
            display: "flex",
            flexDirection: "column",
            justifyContent: "center",
            alignItems: "center",
          }}
        >
          <img
            src={logo}
            alt="Logo"
            style={{
              marginBottom: "1.3rem",
              position: "relative",
              right: resp ? "" : "2rem",
            }}
          />
          <form onSubmit={formik.handleSubmit}>
            <Box
              sx={{
                maxWidth: "31.25rem",
                width: resp ? "100vw" : "31.25rem",
                height: "31.25rem",
                display: "flex",
                flexDirection: "column",
                alignItems: resp ? "center" : "flex-start",
                justifyContent: "center",
                padding: "1rem",
                position: resp ? "relative" : "",
                // left: resp2 ? "26%" : "2rem",
              }}
            >
              <div>
                <span
                  style={{
                    margin: resp3
                      ? "0 6rem 0 -4rem"
                      : resp2
                      ? "0 8rem 0 -5rem"
                      : "0 0 0 1rem",
                    fontWeight: 500,
                  }}
                >
                  First Name
                </span>
                <span
                  style={{
                    margin: resp2 ? "" : "0 0 0 9.5rem",
                    fontWeight: 500,
                  }}
                >
                  Last Name
                </span>
              </div>

              <div style={{ display: "flex" }}>
                {FnameField()}
                {LnameField()}
              </div>

              {EmailField()}

              {ContactField()}

              <div>
                <span
                  style={{
                    margin: resp3
                      ? "0 6rem 0 -4rem"
                      : resp2
                      ? "0 8rem 0 -5rem"
                      : "0 0 0 1rem",
                    fontWeight: 500,
                  }}
                >
                  Date of Birth
                </span>
                <span
                  style={{
                    margin: resp2 ? "" : "0 0rem 0 9rem",
                    fontWeight: 500,
                  }}
                >
                  Password
                </span>
              </div>

              <div style={{ display: "flex" }}>
                {DOBField()}
                {PasswordField()}
              </div>

              <div
                style={{
                  display: "flex",
                  justifyContent: "center",
                  width: resp ? "42ch" : "70ch",
                }}
              >
                <CreateButton type="submit">Create account</CreateButton>
              </div>

              <span
                style={{
                  margin: "2rem 0",
                  fontWeight: 500,
                  position: "relative",
                  left: resp ? "" : "8rem",
                }}
              >
                Already A Member?{" "}
                <Link
                  to="/login"
                  style={{ textDecoration: "none", color: "#A01E86" }}
                >
                  Log in
                </Link>
              </span>
            </Box>
          </form>
        </Grid>
      </Grid>
    </React.Fragment>
  );
};

export default Signup;
