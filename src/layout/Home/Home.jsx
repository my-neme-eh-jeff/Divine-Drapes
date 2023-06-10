import { Flex, Text, ChakraProvider, SimpleGrid, VStack, Link, Input } from '@chakra-ui/react';
import './Home.css';
import { useEffect, useState } from 'react';
import { SearchIcon } from '@chakra-ui/icons';

const Home = () => {
  const [showSearchBar, setShowSearchBar] = useState(true);

  useEffect(() => {
    const handleScroll = () => {
      const scrollPosition = window.pageYOffset || document.documentElement.scrollTop;
      const shouldShowSearchBar = scrollPosition === 0;

      setShowSearchBar(shouldShowSearchBar);
    };

    window.addEventListener('scroll', handleScroll);

    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);
  return (
    <ChakraProvider>
    <Flex justifyContent='space-around' 
    align='center'
    position='absolute'
    width='100%'
    height='400px'
    left='0px'
    top='110px'
    background='linear-gradient(180deg, #A01E86 0%, #F7BC62 100%)'
    >
      <VStack>
        <Text fontSize={38} fontWeight='700' color='#ffffff'>A wide variety of customizable gifts for your loved ones.</Text>
        <SimpleGrid columns={5} columnGap={3} rowGap={2}>
            <Link fontSize={28} fontWeight='500' color='#ffffff'>Mugs</Link>
            <Link fontSize={28} fontWeight='500' color='#ffffff'>Lockets</Link>
            <Link fontSize={28} fontWeight='500' color='#ffffff'>Frames</Link>
            <Link fontSize={28} fontWeight='500' color='#ffffff'>T-Shirts</Link>
        </SimpleGrid>
        <Input type='search' placeholder='Search' bgColor={'#fff'} border='2px solid' />
        </VStack>
    </Flex>
    </ChakraProvider>
  )
}

export default Home