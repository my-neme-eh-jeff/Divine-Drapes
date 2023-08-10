import './Loader.css'
import { Container} from "@mui/material";

export default function Loader() {
  return (
    <>
    <Container sx={{}}>
    <div className="three-body">
    <div className="three-body__dot"></div>
    <div className="three-body__dot"></div>
    <div className="three-body__dot"></div>
    </div>
    </Container>
   
    </>
  )
}
