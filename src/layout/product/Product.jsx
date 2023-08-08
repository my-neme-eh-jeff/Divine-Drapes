import { useEffect, useState } from "react";
import Content from "./Content";
import {
  Box,
  ChakraProvider,
  Heading,
  SimpleGrid,
  Image,
  Button,
} from "@chakra-ui/react";
import { useParams } from "react-router-dom";
import { useNavigate } from "react-router-dom";
import Footer from "../Footer/Footer";
import Navbar from "../Navbar/Navbar";
import useAxiosPrivate from "../../Hooks/useAxiosPrivate";

function Product() {
  const [body, setBody] = useState([]);
  const [catBody, setCatBody] = useState([]);
  const [flag, setFlag] = useState(false);
  const { productId } = useParams();
  const privateAxios = useAxiosPrivate();
  const prodId = productId.split(":")[1];
  const nav = useNavigate();

  // Calculate categoryWise based on flag
  const categoryWise = flag ? catBody?.data : catBody?.data || [];

  useEffect(() => {
    // Call the categoryProduct function when the component mounts or when the flag changes
    categoryProduct();
  }, [flag]);

  const categoryProduct = () => {
    let config = {
      method: "GET",
      url: `product/categoryWise/${body[0]?.data.category}`,
    };
    privateAxios
      .request(config)
      .then((response) => {
        console.log(JSON.stringify(response.data));
        console.log("I am running");
        alert("Category hitted");
        console.log("This is a flag " + flag);
        setFlag(true);
        console.log(response.data);
        setCatBody(response.data);
        // setCatBody([response.data])
      })
      .catch((error) => {
        console.log(error);
      });

    // try {
    //     console.log(privateAxios)
    //     const response = await privateAxios.request(config)
    //     // alert("category Hitted")
    //     console.log("I am runnign")
    //     setFlag(true)
    //     console.log(response.data)
    //     setCatBody(response.data)
    // }
    // catch (err) {
    //     console.log(err)
    // }
  };
  const getSingleProduct = () => {
    let config = {
      method: "GET",
      url: `product/viewProduct/${prodId}`,
    };

    privateAxios
      .request(config)
      .then((response) => {
        // alert("hitted")
        console.log(JSON.stringify(response.data));
        setBody([response.data]);
      })
      .catch((error) => {
        console.log(error);
      });
  };
  useEffect(() => {
    if (flag == false) {
      categoryProduct();
    }
    getSingleProduct();
  }, []);

  const addToCartAPI = () => {
    let config = {
      method: "post",
      url: `user/addCart/${prodId}`,
    };

    privateAxios
      .request(config)
      .then((response) => {
        console.log(JSON.stringify(response.data));
        alert("Added to card");
      })
      .catch((error) => {
        console.log(error);
        alert("Error");
      });
  };

  return (
    <div>
      <Navbar />
      <ChakraProvider>
        <Box className="productbody">
          <br />
          {/* product name here  */}

          <Heading className="namehere">{body[0]?.data.category}</Heading>
          <br />
          <Box height={"auto"} className="mainpro">
            <SimpleGrid h="auto" columns={{ base: 1, md: 3 }} gap={15}>
              <Box
                className="Box"
                display={"flex"}
                justifyContent={"center"}
                alignItems={"center"}
                alignSelf={"center"}
              >
                <Image
                  boxSize="280px"
                  objectFit="cover"
                  src="https://bit.ly/dan-abramov"
                  alt="Dan Abramov"
                />
              </Box>
              <Box
                className="Box"
                display={"flex"}
                justifyContent={"center"}
                alignItems={"left"}
                flexWrap={"center"}
                flexDirection={"column"}
              >
                <p>
                  <Heading fontSize={28} fontWeight={700}>
                    {body[0]?.data.name}
                  </Heading>
                </p>
                <p>{body[0]?.data.description}</p>
                <br />
                <p>
                  <Heading fontSize={24} fontWeight={700}>
                    {" "}
                    ₹ {body[0]?.data.cost.value}
                  </Heading>
                </p>
                <br />
                <Box>
                  <Button
                    onClick={() => nav(`/buy/:${prodId}`)}
                    backgroundColor={"#A01E86"}
                    color={"white"}
                    _hover={{
                      backgroundColor: "#A01E86",
                      color: "black",
                    }}
                  >
                    Buy Now
                  </Button>
                  <Button
                    marginLeft={"25px"}
                    onClick={addToCartAPI}
                    border={" 3px solid #A01E86"}
                  >
                    Add To Cart
                  </Button>
                </Box>
              </Box>
              <Box
                className="Box"
                id="rating"
                display={"flex"}
                alignItems={"left"}
                fontSize={"18px"}
                fontWeight={700}
              >
                <div className="content1">
                  <div className="star" style={{ color: "yellow" }}>
                    <svg
                      stroke="currentColor"
                      fill="currentColor"
                      stroke-width="0"
                      version="1.1"
                      viewBox="0 0 16 16"
                      height="1em"
                      width="1em"
                      xmlns="http://www.w3.org/2000/svg"
                    >
                      <path d="M16 6.204l-5.528-0.803-2.472-5.009-2.472 5.009-5.528 0.803 4 3.899-0.944 5.505 4.944-2.599 4.944 2.599-0.944-5.505 4-3.899z"></path>
                    </svg>
                  </div>
                  <div className="rating" style={{ marginLeft: "8px" }}>
                    4.5
                  </div>
                </div>
              </Box>
            </SimpleGrid>
          </Box>

          <br />
          <Heading fontSize={"28px"} fontWeight={700} lineHeight={"38px"}>
            More Like This..
          </Heading>
          <Box
            display={"flex"}
            flexWrap={"nowrap"}
            padding={"20px"}
            overflowX={"auto"}
            className="recom"
          >
            {categoryWise.map((map) => {
              return (
                <Content
                  title={map.name}
                  price={map.cost.value}
                  desc={map.description}
                />
              );
            })}
          </Box>
        </Box>
        <Footer />
      </ChakraProvider>
    </div>
  );
}

export default Product;
