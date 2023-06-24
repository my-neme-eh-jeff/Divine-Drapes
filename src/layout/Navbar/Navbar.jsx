import { useState } from "react";
import {
  Flex,
  Box,
  Text,
  Link,
  ChakraProvider,
  Avatar,
  WrapItem,
  Button,
} from "@chakra-ui/react";
import { CloseIcon, HamburgerIcon } from "@chakra-ui/icons";
import Categories from "./Categories";
import { useNavigate } from "react-router-dom";


const Navbar = () => {
  const [show, setShow] = useState(false);
  const toggleMenu = () => setShow(!show);

  const navigate = useNavigate();

  return (
    <ChakraProvider>
      <Flex
        p="1% 3%"
        as="nav"
        align="center"
        justify="space-between"
        wrap="wrap"
        w="100%"
        position={"fixed"}
        bgColor={"#fff"}
        zIndex={2}
        // h='80px'
        boxShadow={"0px 5px 3px rgba(0, 0, 0, 0.25)"}
      >
        <Box w="200px">
          <Text
            fontWeight="bold"
            color="#A01E86"
            fontSize={27}
            cursor={"pointer"}
            as="a"
            href="/"
          >
            Divine Drapes
          </Text>
        </Box>

        <Box display={{ base: "block", md: "none" }} onClick={toggleMenu}>
          {show ? <CloseIcon /> : <HamburgerIcon />}
        </Box>

        <Box
          display={{ base: show ? "block" : "none", md: "block" }}
          flexBasis={{ base: "100%", md: "auto" }}
        >
          <Flex
            align="center"
            justify={["center", "space-between", "flex-end", "flex-end"]}
            direction={["column", "row", "row", "row"]}
            pt={[4, 4, 0, 0]}
          >
            
            <Link>
              <Categories />
            </Link>

            <Link href="/bulkorder">
              <Button bgColor={'#fff'}>
                  Bulk orders
              </Button>
            </Link>
            <Link href="/cart">
            <Button bgColor={'#fff'}>
                  Cart
                </Button>
            </Link>
            <WrapItem onClick={() => navigate('/profile')} cursor='pointer'>
              <Avatar name="Dan Abrahmov" src="https://bit.ly/dan-abramov" />
            </WrapItem>
          </Flex>
        </Box>
      </Flex>
    </ChakraProvider>
  );
};

export default Navbar;
