import * as yup from "yup";
import { useState } from "react";
import {
  Box,
  Button,
  FormControl,
  OutlinedInput,
  InputAdornment,
} from "@mui/material";
import { styled } from "@mui/material/styles";
import { useEffect } from "react";
import { useNavigate } from "react-router-dom";
import Grid from "@mui/material/Grid";
import EmailOutlinedIcon from "@mui/icons-material/EmailOutlined";
import giftbox from "../images/giftbox.png";
import React from "react";
import "./Login.css";
import { useFormik } from "formik";
import logo from "../images/logo.png";
import publicAxios from "../Axios/publicAxios";

const validationSchema = yup.object({
  email: yup
    .string("Enter your email")
    .email("Enter a valid email")
    .required("Email is required"),
});

const ForgOtpBtnass = () => {
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
  //

  let navigate = useNavigate();

  const formik = useFormik({
    initialValues: {
      email: "",
    },
    validationSchema: validationSchema,
    onSubmit: async (values) => {
      try {
        const options = {
          url: "auth/forgotPSWD",
          method: "POST",
          data: values,
        };
        const resp = await publicAxios.request(options);
        const path = `/otpverify`;
        navigate(path);
      } catch (err) {
        //display error
      }
    },
  });

  const OtpBtn = styled(Button)({
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
    "&:hover": { backgroundColor: "#b945a2", color: "white" },
  });

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

  const EmailField = () => {
    return (
      <React.Fragment>
        <span
          style={{
            position: "relative",
            right: resp ? "8.5rem" : "12rem",
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
            placeholder="  Enter your Email address "
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

  const SendOtp = () => {
    return (
      <>
        <div
          style={{
            display: "flex",
            justifyContent: "center",
            width: resp ? "42ch" : "70ch",
          }}
        >
          <OtpBtn type="submit">Send Otp</OtpBtn>
        </div>
      </>
    );
  };

  return (
    <React.Fragment>
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
          <Grid
            item
            xs={6}
            style={{
              display: "flex",
              flexDirection: "column",
              justifyContent: "flex-start",
              alignItems: "center",
              // height: "36rem",
            }}
          >
            <img
              src={logo}
              alt="Logo"
              style={{
                marginBottom: "1.3rem",
                position: "relative",
                // right: resp ? "" : "2rem",
              }}
            />
            <form onSubmit={formik.handleSubmit}>
              <Box
                sx={{
                  maxWidth: "31.25rem",
                  width: resp ? "100vw" : "31.25rem",
                  height: "18rem",
                  display: "flex",
                  flexDirection: "column",
                  alignItems: "center",
                  justifyContent: "center",
                  padding: "1rem",
                  position: resp ? "relative" : "",
                  // left: resp2 ? "26%" : "2rem",
                }}
              >
                <p
                  style={{
                    color: "#A01E86",
                    fontFamily: "Nano Sans",
                    fontWeight: 600,
                    fontSize: "1.5rem",
                    alignContent: "center",
                    margin: "0rem",
                  }}
                >
                  Forgot Password?
                </p>
                <p
                  style={{
                    fontFamily: "Nano Sans",
                    fontWeight: 500,
                    fontSize: "1rem",
                    lineHeight: "1.5rem",
                    marginBottom: "3rem",
                  }}
                >
                  Confirm your Email address to receive an OTP.
                </p>

                {EmailField()}

                {SendOtp()}
              </Box>
            </form>
          </Grid>
          <Grid item xs={6} className="img2 c">
            <GiftGridI />
          </Grid>
        </Grid>
      </React.Fragment>
    </React.Fragment>
  );
};

export default ForgOtpBtnass;
