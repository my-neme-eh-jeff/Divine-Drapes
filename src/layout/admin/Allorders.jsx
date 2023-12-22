/* eslint-disable react/prop-types */
import { Button, CircularProgress, Grid, Typography } from "@mui/material";
import React, { useEffect, useState } from "react";
import FormGroup from "@mui/material/FormGroup";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import Box from "@mui/material/Box";
import Tab from "@mui/material/Tab";
import TabContext from "@mui/lab/TabContext";
import TabList from "@mui/lab/TabList";
import TabPanel from "@mui/lab/TabPanel";
import useAuth from "../../Hooks/useAuth";
import { useNavigate } from "react-router-dom";
import mug from "./coffee.png";
import useAxiosPrivate from "../../Hooks/useAxiosPrivate";

export default function Allorders() {
  const [loading, setLoading] = useState(false);
  const privateAxios = useAxiosPrivate();
  const [value, setValue] = React.useState("1");
  const [orders, setOrders] = React.useState({
    oldOrders: [],
    newOrders: [],
  });
  const [progress, setProgress] = useState(0);
  const navigate = useNavigate();
  const handleChange = (event, newValue) => {
    setValue(newValue);
  };

  const getAllOrder = async () => {

    setLoading(true);
    const options = {
      url: "admin/allOrders",
      method: "GET",
    };
    try {
      const resp = await privateAxios.request(options);
      setOrders({
        oldOrders: resp.data.received,
        newOrders: resp.data.delivered,
      });
    } catch (err) {
      console.log(err);
    } finally {
      setLoading(false);
    }
  };

  useEffect(() => {
    getAllOrder();
    console.log(orders);
  }, []);

  return (
    <>
      <Grid container>
        {/* Left Side - Categories */}
        <Grid item md={2} sx={{ padding: 3 }} columnSpacing={4}>
          <Grid container rowSpacing={4}>
            <Grid item md={12}>
              Categories
            </Grid>
            <Button sx={{mt: '5%'}} onClick={() => navigate('/admin/addpro')}>Add Product</Button>
            <Grid item md={12}>
              {/* <FormGroup>
                <FormControlLabel control={<Checkbox />} label="Label" />
                <FormControlLabel control={<Checkbox />} label="Required" />
                <FormControlLabel control={<Checkbox />} label="Disabled" />
              </FormGroup> */}
            </Grid>
          </Grid>
        </Grid>

        {/* Right Side - Orders */}
        <Grid item md={10} sx={{ padding: 3 }}>
          <Box sx={{ width: "100%", typography: "body1" }}>
            <TabContext value={value}>
              <Box sx={{ borderBottom: 1, borderColor: "divider" }}>
                <TabList
                  onChange={handleChange}
                  aria-label="lab API tabs example"
                >
                  <Tab label="New Orders" value="1" />
                  <Tab label="Old Orders" value="2" />
                </TabList>
              </Box>
              <TabPanel value="1">
                <OrdersList
                  loading={loading}
                  orders={orders.newOrders}
                  progress={progress}
                />
              </TabPanel>
              <TabPanel value="2">
                <OrdersList
                  orders={orders.oldOrders}
                  loading={loading}
                  progress={progress}
                />
              </TabPanel>
            </TabContext>
          </Box>
        </Grid>
      </Grid>
    </>
  );
}

// OrderCard component that represents a single order card
function OrderCard({ order }) {
  const navigate = useNavigate();
  return (
    <div>
      <Grid container>
        <Grid item md={10} sx={{ backgroundColor: "white" }}>
          <Grid container>
            <Grid item md={2} sx={{}}>
              <img src={mug} style={{ width: "60%", borderRadius: 10 }} />
            </Grid>
            <Grid item md={4}>
              <Typography variant="h5" sx={{ fontWeight: 4 }}>
                {order.product?.name || "Product"}
              </Typography>
              <div
                style={{
                  margin: 20,
                  border: "black solid 2px",
                  borderRadius: 5,
                  marginRight: 80,
                  marginLeft: 0,
                  textAlign: "center",
                }}
              >
                Photo Attached
              </div>
            </Grid>
            <Grid item md={3}>
              <Typography
                variant="h7"
                style={{ marginBottom: 25, fontSize: 18 }}
              >
                Payment:{order.paymentType || "N/A"}
              </Typography>
              <div style={{ marginTop: 25, fontSize: 18 }}>
                {order.createdAt || Date.now().toLocaleString()}
              </div>
            </Grid>
            <Grid
              item
              md={1}
              sx={{
                display: "flex",
                justifyContent: "center",
                alignItems: "center",
              }}
            >
              <Button
                size="small"
                variant="contained"
                onClick={() => navigate(`/admin/orders/view/:${order._id}`)}
                sx={{
                  color: "white",
                  backgroundColor: "#A01E86",
                  "&:hover": { backgroundColor: "#A01E86", border: 2 },
                }}
              >
                View
              </Button>
            </Grid>
            <Grid item md={2}></Grid>
          </Grid>
        </Grid>
      </Grid>
    </div>
  );
}

// OrdersList component to map through the orders and display the order cards
function OrdersList({ orders, loading, progress }) {
  return (
    <>
      {!loading ? (
        orders.map((order, index) => <OrderCard key={index} order={order} />)
      ) : (
        <>
          <CircularProgress />
        </>
      )}
    </>
  );
}
