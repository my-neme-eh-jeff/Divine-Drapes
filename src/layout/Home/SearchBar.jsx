import { Input, InputLeftElement, InputGroup, InputRightElement, Button } from '@chakra-ui/react';
import { SearchIcon } from '@chakra-ui/icons';

const SearchBar = () => {
  return (
    <InputGroup id='search-bar'>
        <InputLeftElement mt='1%'>
            <SearchIcon />
        </InputLeftElement>
        <Input placeholder='Search' border={'2px'} bgColor={'#fff'} height={'50px'}/>
        <InputRightElement m='1% 5%'>
            <Button bgColor={'#A01E86'} size={'60px'} height='30px' color='#fff'>Explore</Button>
        </InputRightElement>
    </InputGroup>
  )
}

export default SearchBar