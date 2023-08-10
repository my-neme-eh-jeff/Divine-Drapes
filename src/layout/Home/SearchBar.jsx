import { Input, InputLeftElement, InputGroup, InputRightElement, Button, Box } from '@chakra-ui/react';
import { SearchIcon } from '@chakra-ui/icons';

const SearchBar = () => {
  return (
    <Box>
    <InputGroup id='search-bar'>
        <InputLeftElement mt='1%' ml='1%'>
            <SearchIcon />
        </InputLeftElement>
        <Input placeholder='Search' border={'2px'} bgColor={'#fff'} height={'50px'}/>
        <InputRightElement width={'80px'} m={'0 2%'} mt={['1.4%', null, '0.8%']}>
        <Button
          bgColor={'#A01E86'}
          color='#fff'
          _hover={{ bgColor: '#7A146B' }}
        >
          Explore
        </Button>
        </InputRightElement>
    </InputGroup>
    </Box>
  )
}

export default SearchBar