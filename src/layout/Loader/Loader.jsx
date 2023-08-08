import React from 'react'
import '../styles/Loader.css'
import { Container} from "@mui/material";

export default function Loader() {
  return (
    <>
    <Container sx={{}}>
    <div class="three-body">
    <div class="three-body__dot"></div>
    <div class="three-body__dot"></div>
    <div class="three-body__dot"></div>
    </div>
    </Container>
   
    </>
  )
}
