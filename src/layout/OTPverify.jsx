import { useState } from "react";
import OtpInput from "react-otp-input";
import { Box, Button,TextField } from "@mui/material";
import { styled } from "@mui/material/styles";
import { useEffect } from "react";
import Grid from "@mui/material/Grid";
import giftbox from "../images/giftbox.png";
import React from "react";
import "./Login.css";
import logo from "../images/logo.png";
import { useTimer } from "react-timer-hook";
import { useLocation, useNavigate } from "react-router";
import { Link } from "react-router-dom";

const OTPverify = ({email,page,setPage}) => {
  // adding event listener for responsiveness
  const [width, setWindowWidth] = useState(0);

  // let navigate = useNavigate();
  // const [email, setEmail] = useState();
  // const location = useLocation();
  // if (location?.state?.OTPMail) {
  //   console.log(location?.state?.OTPMail);
  //   setEmail(location?.state?.OTPMail);
  // } else {
  //   navigate(-1);
  // }

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

  const EmailField = () => {
    return (
      <>
        <TextField
          id="email"
          type="text"
          label={email}
          placeholder="email"
          name="email"
          disabled
          style={{ width: resp3 ? "20rem" : "27.8rem",}}
        />
      </>
    );
  };

  const ContinueBtn = styled(Button)({
    backgroundColor: "#A01E86",
    borderRadius: "0.3rem",
    textDecoration: "none",
    padding: "12px 15px ",
    width: resp3 ? "20rem" : "27.8rem",
    height: "3.1875rem",
    color: "white",
    fontSize: "0.8rem",
    marginTop: "0.5rem",
    position: "relative",
    "&:hover": { backgroundColor: "#b945a2", color: "white" },
  });

  const ResendOtpBtn = styled(Button)({
    backgroundColor: "#A01E86",
    borderRadius: "0.3rem",
    textDecoration: "none",
    padding: "12px 15px ",
    width: resp3 ? "20rem" : "27.8rem",
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

  const [otp, setOtp] = React.useState("");

  const handleChange = (otp) => {
    setOtp(otp);
  };

  const OtpIp = () => {
    return (
      <>
        <p
          style={{
            fontWeight: 500,
            fontSize: "1rem",
            lineHeight: "1.5rem",
          }}
        >
          Enter OTP
        </p>
        <OtpInput
          value={otp}
          onChange={handleChange}
          numInputs={6}
          renderSeparator={<span>&nbsp;&nbsp;&nbsp;&nbsp;</span>}
          renderInput={(props) => <input {...props} />}
          // containerStyle={{width:'10rem', border:'2px solid red'}}
        />
      </>
    );
  };

  const [isSubmitted, setIsSubmitted] = useState(false);

  const handleFormSubmit = (event) => {
    event.preventDefault();
    console.log(`OTP = ${otp}`);
    setIsSubmitted(true); // Pause the timer
    setPage(() => 3)
  };



  function MyTimer({ expiryTimestamp }) {
    const { seconds, minutes, isRunning, start, restart } = useTimer({
      expiryTimestamp,
      onExpire: () => console.warn("onExpire called"),
    });

    return (
      <div style={{}}>
        <div
          style={{
            color: "red",
            marginTop: "0.5rem",
            fontSize: "0.7rem",
            position: "relative",
            left: resp ? "11.3rem" : "19rem",
            display: isRunning ? (isSubmitted ? "none" : "") : "none",
          }}
        >
          <span>Resend OTP in : {minutes < 10 ? `0${minutes}` : minutes}</span>:
          <span>{seconds < 10 ? `0${seconds}` : seconds}</span>
        </div>

        <div
          style={{
            display: "flex",
            justifyContent: "center",
            width: resp ? "42ch" : "70ch",
          }}
        >
          {isRunning ? (
            <ContinueBtn className="submit-btn" type="submit">
              Continue
            </ContinueBtn>
          ) : (
            <ResendOtpBtn
              className="resend-btn"
              type="submit"
              onClick={() => {
                // Restarts to 1 minutes timer
                const time = new Date();
                time.setSeconds(time.getSeconds() + 300);
                restart(time);
              }}
            >
              Resend OTP
            </ResendOtpBtn>
          )}
        </div>
      </div>
    );
  }

  const time = new Date();
  time.setSeconds(time.getSeconds() + 60); // 1 minutes timer

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
          width: resp ? "100vw" : "",
          height: resp ? "100vh" : "",
        }}
      >
        <Grid
          item
          xs={6}
          style={{
            display: "flex",
            flexDirection: "column",
            justifyContent: resp ? "center" : "flex-start",
            alignItems: "center",
          }}
        >
          <img
            src={logo}
            alt="Logo"
            style={{
              marginBottom: "1.3rem",
              position: "relative",
            }}
          />
          <form onSubmit={handleFormSubmit}>
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
                Enter the OTP received on your email address
              </p>

              {EmailField()}
              <Link onClick={() => setPage(1)} style={{color:'red',textDecoration:'none',marginTop:'0.3rem',position:'relative',left:'35%'}}>
                Reset Email
              </Link>

              {OtpIp()}

              <div>
                <MyTimer expiryTimestamp={time} />
              </div>

            </Box>
          </form>
        </Grid>
        <Grid item xs={6} className="img2 c">
          <GiftGridI />
        </Grid>
      </Grid>
    </React.Fragment>
  );
};

export default OTPverify;
