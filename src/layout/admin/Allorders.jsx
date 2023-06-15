import { Grid } from "@mui/material";
import React from "react";
import FormGroup from "@mui/material/FormGroup";
import FormControlLabel from "@mui/material/FormControlLabel";
import Checkbox from "@mui/material/Checkbox";
import Box from '@mui/material/Box';
import Tab from '@mui/material/Tab';
import TabContext from '@mui/lab/TabContext';
import TabList from '@mui/lab/TabList';
import TabPanel from '@mui/lab/TabPanel';
import New from "./New";
import Old from "./Old"

export default function Allorders() {
  const [value, setValue] = React.useState('1');
  const handleChange = (event, newValue) => {
    setValue(newValue);
  };
  return (
    <>
      <Grid container >
        <Grid item md={2} sx={{ backgroundColor: "red",padding:3 }} columnSpacing={4}>
          <Grid container rowSpacing={4}>
            <Grid item md={12}>
              Catagories
            </Grid>

            <Grid item md={12}>
              <FormGroup>
                <FormControlLabel
                  control={<Checkbox/>}
                  label="Label"
                />
                <FormControlLabel
                  control={<Checkbox />}
                  label="Required"
                />
                <FormControlLabel
                  control={<Checkbox />}
                  label="Disabled"
                />
              </FormGroup>
            </Grid>
          </Grid>
        </Grid>
        <Grid item md={10} sx={{ backgroundColor: "green",padding:3 }}>
        <Box sx={{ width: '100%', typography: 'body1' }}>
      <TabContext value={value}>
        <Box sx={{ borderBottom: 1, borderColor: 'divider' }}>
          <TabList onChange={handleChange} aria-label="lab API tabs example">
            <Tab label="New Orders" value="1" />
            <Tab label="Old Orders" value="2" />
          </TabList>
        </Box>
        <TabPanel value="1"><New/></TabPanel>
        <TabPanel value="2"><Old/></TabPanel>
      </TabContext>
    </Box>
        </Grid>
      </Grid>
    </>
  );
}
