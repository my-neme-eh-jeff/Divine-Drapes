import { CircularProgress, Grid, Typography } from "@mui/material";
import FormGroup from "@mui/material/FormGroup";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import Box from "@mui/material/Box";
import Button from "@mui/material/Button";
import mug from "./coffee.png";
import { useNavigate, useParams } from "react-router-dom";
import { useEffect, useState } from "react";
import useAxiosPrivate from "../../Hooks/useAxiosPrivate";

export default function ViewOrders() {
  const [loading, setLoading] = useState(false);
  const { orderId } = useParams();
  const navigate = useNavigate();
  const axiosPrivate = useAxiosPrivate()
  const [order, setOrder] = useState();

  useEffect(() => {
    const getOrderDetails = async () => {
      const options = {
        url: `user/singleOrder/${orderId.split(":")[1]}`,
        method: "GET",
      };
      try {
        const resp = await axiosPrivate.request(options);
        setOrder(resp.data);
      } catch (err) {
        console.log(err);
        // navigate(-1);
      }
    };

    getOrderDetails();
  }, []);

  return (
    <>
      {loading ? (
        <CircularProgress />
      ) : (
        <Grid container>
          <Grid item md={2} sx={{ padding: 3 }} columnSpacing={4}>
            <Grid container rowSpacing={4}>
              <Grid item md={12}>
                Catagories
              </Grid>

              <Grid item md={12}>
                <FormGroup>
                  <FormControlLabel control={<Checkbox />} label="Label" />
                  <FormControlLabel control={<Checkbox />} label="Required" />
                  <FormControlLabel control={<Checkbox />} label="Disabled" />
                </FormGroup>
              </Grid>
            </Grid>
          </Grid>
          <Grid item md={10} sx={{ padding: 3 }}>
            <Box sx={{ width: "100%" }}>
              <Box>
                <Typography variant="h6" sx={{ fontWeight: "bold" }}>
                  New Orders
                </Typography>
              </Box>
              <Grid container>
                <Grid item xs={12} md={2}>
                  <img src={mug} style={{ width: "150px", borderRadius: 10 }} />
                </Grid>
                <Grid item xs={12} md={4}>
                  <Grid
                    container
                    display="flex"
                    flexDirection={"column"}
                    rowSpacing={2}
                  >
                    <Grid item>
                      <Typography variant="h6" sx={{ fontWeight: "bold" }}>
                        M1 White Mug
                      </Typography>
                    </Grid>
                    <Grid item>
                      <Typography sx={{ fontSize: "18px" }}>
                        Name: Jenny
                      </Typography>
                    </Grid>
                    <Grid item>
                      <Typography sx={{ fontSize: "18px" }}>
                        Contact Number: Jenny
                      </Typography>
                    </Grid>
                    <Grid item>
                      <Typography sx={{ fontSize: "18px" }}>
                        Email Id: Jenny
                      </Typography>
                    </Grid>
                    <Grid item>
                      <Typography sx={{ fontSize: "18px" }}>
                        Payment: Jenny
                      </Typography>
                    </Grid>
                    <Grid item>
                      <Typography sx={{ fontSize: "18px" }}>
                        Address: Jenny
                      </Typography>
                    </Grid>
                    <Grid item>
                      <div
                        style={{
                          border: "black solid 2px",
                          borderRadius: 5,
                          marginBottom: 20,
                          textAlign: "center",
                          padding: "2%",
                          width: "300px",
                        }}
                      >
                        Photo Attached
                      </div>
                    </Grid>
                  </Grid>
                </Grid>
                <Grid item>
                  <Typography sx={{ fontSize: "18px" }}>Date: </Typography>
                </Grid>
                <Grid container marginLeft={"17%"}>
                  <Button
                    size="small"
                    variant="contained"
                    sx={{
                      color: "white",
                      backgroundColor: "#A01E86",
                      p: "1% 2%",
                      "&:hover": { backgroundColor: "#A01E86", border: 2 },
                    }}
                  >
                    Done
                  </Button>
                </Grid>
              </Grid>
            </Box>
          </Grid>
        </Grid>
      )}
    </>
  );
}
