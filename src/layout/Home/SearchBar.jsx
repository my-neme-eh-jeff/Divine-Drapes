import { Input, InputLeftElement, InputGroup, InputRightElement, Button } from '@chakra-ui/react';
import { SearchIcon } from '@chakra-ui/icons';

const SearchBar = () => {
  return (
    <InputGroup id='search-bar'>
        <InputLeftElement mt='1%' ml='1%'>
            <SearchIcon />
        </InputLeftElement>
        <Input placeholder='Search' border={'2px'} bgColor={'#fff'} height={'50px'}/>
        <InputRightElement width={'80px'} m={'0.8% 2%'}>
            <Button bgColor={'#A01E86'} color='#fff'>Explore</Button>
        </InputRightElement>
    </InputGroup>
  )
}

export default SearchBar