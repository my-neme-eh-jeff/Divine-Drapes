import {
  Flex,
  Text,
  ChakraProvider,
  SimpleGrid,
  Link,
  Box,
  Heading,
} from "@chakra-ui/react";
import "./Home.css";
import TopSellingCarousel from "./TopSelling";
import Testimonials from "./Testimonials";
import Personalised from "./Personalised";
import SearchBar from "./SearchBar";
import Navbar from "../Navbar/Navbar.jsx";
import Footer from "../Footer/Footer.jsx";

const Home = () => {
  return (
    <ChakraProvider>
      <Navbar />
      <Box pt="5%">
        <Flex
          justifyContent="space-around"
          align="center"
          // position='absolute'
          width="100%"
          height="400px"
          left="0px"
          top="110px"
          background="linear-gradient(180deg, #A01E86 0%, #F7BC62 100%)"
          mb="1%"
        >
          <Flex flexDirection={"column"}>
            <Heading textAlign={'center'} color={'#fff'} size={'xl'}>
            A wide variety of customizable gifts for your loved ones.
            </Heading>
            <SimpleGrid columns={4} columnGap={1} rowGap={2} m="2% 3% 3% 7%">
              <Link className="home-tags" color="#fff">
                Lockets
              </Link>
              <Link className="home-tags" color="#fff">
                Frames
              </Link>
              <Link className="home-tags" color="#fff">
                Mugs
              </Link>
              <Link className="home-tags" color="#fff">
                T-shirts
              </Link>
            </SimpleGrid>
            <SearchBar />
          </Flex>
        </Flex>
        <Box m="0 8%">
          <Text class="home-headings">
            Personalised Gifts for all occasions
          </Text>
          <Personalised />
          <Text class="home-headings">Top Selling</Text>
          <TopSellingCarousel />
          <Text class="home-headings">Testimonials</Text>
          <Testimonials />
        </Box>
      </Box>
      <Footer />
    </ChakraProvider>
  );
};

export default Home;
