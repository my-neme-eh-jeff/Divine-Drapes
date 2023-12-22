import {
  Input,
  InputLeftElement,
  InputGroup,
  InputRightElement,
  Button,
  Box,
} from "@chakra-ui/react";
import { SearchIcon } from "@chakra-ui/icons";
import { useState } from "react";
import privateAxios from "../../Axios/privateAxios";
import useAuth from "../../Hooks/useAuth";
import { useNavigate } from "react-router-dom";


const SearchBar = () => {
  const { auth, setAuth } = useAuth();
  const isLogin = auth?.accessToken;

  const navigate = useNavigate();

  const [searchTerm, setSearchTerm] = useState("");

  const handleExploreClick = async () => {
    try {
      console.log(searchTerm);
      navigate(`/search?selected=${searchTerm}`);
    } catch (error) {
      console.error("Error during fetch:", error.message);
    }
  };

  return (
    <Box>
      <InputGroup id="search-bar">
        <InputLeftElement mt="1%" ml="1%">
          <SearchIcon />
        </InputLeftElement>
        <Input
          placeholder="Search"
          border={"2px"}
          bgColor={"#fff"}
          height={"50px"}
          value={searchTerm}
          onChange={(e) => setSearchTerm(e.target.value)}
        />
        <InputRightElement
          width={"80px"}
          m={"0 2%"}
          mt={["1.4%", null, "0.8%"]}
        >
          <Button
            bgColor={"#A01E86"}
            color="#fff"
            _hover={{ bgColor: "#7A146B" }}
            onClick={handleExploreClick}
          >
            Explore
          </Button>
        </InputRightElement>
      </InputGroup>
    </Box>
  );
};

export default SearchBar;
