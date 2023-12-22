import { useState, useEffect } from "react";
import {
  Flex,
  Box,
  Text,
  Link,
  ChakraProvider,
  Avatar,
  Button,
  Menu,
  MenuButton,
  MenuList,
  MenuItem,
} from "@chakra-ui/react";
import { CloseIcon, HamburgerIcon } from "@chakra-ui/icons";
import Categories from "./Categories";
import SearchBar from "../Home/SearchBar";
import useAuth from "../../Hooks/useAuth";
import useLogout from "../../Hooks/useLogout";
import { useNavigate } from "react-router-dom";
import jwt_decode from "jwt-decode";

const Navbar = () => {
  const [show, setShow] = useState(false);
  const toggleMenu = () => setShow(!show);
  const [showSearchBar, setShowSearchBar] = useState(false);
  const { auth } = useAuth();
  const logout = useLogout();
  const navigate = useNavigate();
  const adminRole = import.meta.env.VITE_ADMIN_ROLE
  const decoded = auth?.accessToken ? jwt_decode(auth.accessToken) : undefined;
  const role = decoded?.UserInfo;
  const checkRole = role?.roles
  let roleLen = 1
  if(checkRole) {
    roleLen = (checkRole?.length) - 1
    var finalRole = checkRole[roleLen]
  }
  console.log(adminRole == finalRole)
  const handleLogout = async () => {
    try {
      await logout();
      navigate("/");
    } catch (err) {
      console.log(err);
    }
  };

  useEffect(() => {
    const handleScroll = () => {
      const scrollTop = window.scrollY || document.documentElement.scrollTop;
      setShowSearchBar(scrollTop > 300);
    };

    window.addEventListener("scroll", handleScroll);
    return () => {
      window.removeEventListener("scroll", handleScroll);
    };
  }, []);

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
            <Box mr="5%">
              {window.location.pathname === "/" ? (
                showSearchBar && <SearchBar />
              ) : (
                <SearchBar />
              )}
            </Box>
            { adminRole == finalRole ?
              <Link href="/admin/orders">
                <Button bgColor={"#fff"}>Admin</Button>
              </Link>
            :
            <Link href="/">
              <Button bgColor={"#fff"}>Home</Button>
            </Link>
            }
            <Link>
              <Categories />
            </Link>

            <Link href="/bulkorder">
              <Button bgColor={"#fff"}>Bulk orders</Button>
            </Link>
            <Link href="/fav">
              <Button bgColor={"#fff"}>Cart</Button>
            </Link>
            {!auth.accessToken ? (
              <Link href="/login">
                <Button bgColor={"#f7bc62"}>Login</Button>
              </Link>
            ) : (
            <Menu>
              <MenuButton bgColor='white'>
                <Avatar />
              </MenuButton>
              <MenuList>
                <MenuItem onClick={handleLogout}>Logout</MenuItem>
                <MenuItem onClick={() => navigate('/profile')}>My Accounts</MenuItem>
              </MenuList>
            </Menu>
            )
          }
          </Flex>
        </Box>
      </Flex>
    </ChakraProvider>
  );
};

export default Navbar;
