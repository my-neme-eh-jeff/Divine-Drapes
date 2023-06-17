import React, { useState, useEffect } from "react";
import {
  Flex,
  Box,
  Text,
  Link,
  ChakraProvider,
  Avatar,
  WrapItem,
  PopoverTrigger,
  PopoverContent,
  PopoverHeader,
  Button,
  PopoverBody,
  Popover,
  SimpleGrid,
  GridItem,
  VStack,
} from "@chakra-ui/react";
import { ChevronDownIcon, ChevronUpIcon, CloseIcon, HamburgerIcon } from "@chakra-ui/icons";
import axios from "axios";
import '../Home/Home.css';

const MenuItem = ({ children, isLast, to = "/" }) => {
  return (
    <Text
      mb={{ base: isLast ? 0 : 8, sm: 0 }}
      mr={{ base: 0, sm: isLast ? 0 : 8 }}
      display="block"
    >
      <Link href={to}>{children}</Link>
    </Text>
  );
};

const Navbar = () => {
  const [show, setShow] = useState(false);
  const toggleMenu = () => setShow(!show);
  const initialFocusRef = React.useRef();
  const [downIcon, setDownIcon] = useState(false);
  const [categories, setCategories] = useState([]);
  const [selected, setSelected] = useState([]);

    useEffect(() => {
        axios.get('https://dummyjson.com/posts')
        .then(res => setCategories(res.data.posts))
      },[])

      const handleItem = (e) => {
        console.log(e.id)
      }
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
            href="/home"
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
            {/* <MenuItem> */}
            <Popover
              initialFocusRef={initialFocusRef}
              placement="bottom"
              closeOnBlur={false}
            >
              <PopoverTrigger>
                <Button bgColor={'#fff'} onClick={() => setDownIcon(!downIcon)}>
                  Categories {downIcon ? <ChevronUpIcon /> : <ChevronDownIcon /> }
                </Button>
              </PopoverTrigger>
              <PopoverContent
                boxShadow={'-4px -4px 6px rgba(0, 0, 0, 0.25), 4px 4px 10px rgba(0, 0, 0, 0.25)'}
                width={['100%', null, '100%']}
                p='2%'
              >
                <PopoverHeader pt={4} fontWeight="bold" border="0">
                  Selected
                </PopoverHeader>
                <PopoverBody>
                    <Button border='1px' bgColor={'#f7bc62'} p='0 0 0 1%'>
                      <SimpleGrid columns={2}>
                        <GridItem>Mugs</GridItem>
                        <GridItem><CloseIcon w='3' h='3'/></GridItem>
                      </SimpleGrid>
                    </Button>
                </PopoverBody>
                <PopoverHeader pt={4} fontWeight="bold" border="0">
                  All categories
                </PopoverHeader>
                <PopoverBody>
                    <SimpleGrid columns={[4, null, 8]} columnGap={[2, null, 6]} rowGap={[2, null, 6]}>
                      {categories?.map(items => (
                        // return(
                        <GridItem key={items.id} onClick={handleItem}><Button border={'1px'} bgColor={'#fff'}>Mugs</Button></GridItem>
                      ))}
                    </SimpleGrid>
                </PopoverBody>
              </PopoverContent>
            </Popover>
            {/* </MenuItem> */}
            <MenuItem to="/bulkorder"><Button bgColor={'#fff'}>
                  Bulk orders
                </Button></MenuItem>
            <MenuItem to="/cart">
            <Button bgColor={'#fff'}>
                  Cart
                </Button>
            </MenuItem>
            <WrapItem>
              <Avatar name="Dan Abrahmov" src="https://bit.ly/dan-abramov" />
            </WrapItem>
          </Flex>
        </Box>
      </Flex>
    </ChakraProvider>
  );
};

export default Navbar;
