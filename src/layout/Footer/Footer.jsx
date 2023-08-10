import {
    Box,
    Container,
    Link,
    SimpleGrid,
    Stack,
    Text,
    useColorModeValue,
    Image,
    Textarea,
    Button,
    Flex,
  } from '@chakra-ui/react';
  import { ChakraProvider } from '@chakra-ui/react'
  import Logodd from '../../assets/ddlogo.png'
import { useNavigate } from 'react-router-dom';
  

const Logo = (props) => {
    const navigate = useNavigate();
    return (
        <Image
        boxSize='150px'
        objectFit='cover'
        borderRadius={'50%'}
        src={Logodd}
        alt='DD logo'
        _hover={{ cursor: 'pointer' }}
        onClick={() => navigate('/')}
      />
    );
  };
  
  
  const ListHeader = ({ children }) => {
    return (
      <Text fontWeight={'500'} fontSize={'lg'} mb={2}>
        {children}
      </Text>
    );
  };
  
  export default function Footer() {
    return (
        <ChakraProvider>
      <Box
        bg={useColorModeValue('gray.50', 'gray.900')}
        backgroundColor={'#F7BC62'}
        className='containerbodyfooter'
        width="100%"
        // maxW="1200px" // Adjust the maximum width based on your design requirements
        color={'black'}>
        <Container as={Stack}  maxW={'6xl'} py={10}>
          <SimpleGrid
            columns={{md:5,sm:1}}
            spacing={8}>
            <Stack spacing={6}  display={'flex'} alignSelf={'center'} flexDirection={'row'}>
              <Box color={'#A01E86'} fontSize={'38px'} fontWeight={700} lineHeight={'52px'} textAlign={'center'}  >
                <Logo color={useColorModeValue('gray.700', 'white')} />
                {/* <Text>Divine Drapes</Text> */}
              </Box>
            </Stack>
            <Stack align={'flex-start'}>
              <ListHeader>Top Products</ListHeader>
              <Link href={'#'}>Mugs</Link>
              <Link href={'#'}>Keychains</Link>
              <Link href={'#'}>T-shirts</Link>
              <Link href={'#'}>Frames</Link>
              <Link href={'#'}>Wallets</Link>
              <Link href={'#'}>bags</Link>
              <Link href={'#'}>Tags</Link>
              <Link href={'#'}>& more</Link>
            </Stack>
            <Stack align={'flex-start'}>
              <ListHeader>Services</ListHeader>
              <Link href={'#'}>My Account</Link>
              <Link href={'#'}>My Cart</Link>
              <Link href={'#'}>Bulk orders</Link>
            </Stack>
            <Stack align={'flex-start'}>
              <ListHeader>Contact us</ListHeader>
              <Link href={'#'}><Stack direction={'row'} alignItems={'center'}>
                <Box>
                <svg stroke="currentColor" fill="currentColor" strokeWidth="0" viewBox="0 0 1024 1024" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M928 160H96c-17.7 0-32 14.3-32 32v640c0 17.7 14.3 32 32 32h832c17.7 0 32-14.3 32-32V192c0-17.7-14.3-32-32-32zm-40 110.8V792H136V270.8l-27.6-21.5 39.3-50.5 42.8 33.3h643.1l42.8-33.3 39.3 50.5-27.7 21.5zM833.6 232L512 482 190.4 232l-42.8-33.3-39.3 50.5 27.6 21.5 341.6 265.6a55.99 55.99 0 0 0 68.7 0L888 270.8l27.6-21.5-39.3-50.5-42.7 33.2z"></path></svg>
                </Box>
                <Text>abc@gmail.com</Text>
                </Stack></Link>
              <Link href={'#'}><Stack direction={'row'} alignItems={'center'}>
                <Box>
                <svg stroke="currentColor" fill="none" strokeWidth="2" viewBox="0 0 24 24" strokeLinecap="round" strokeLinejoin="round" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path d="M22 16.92v3a2 2 0 0 1-2.18 2 19.79 19.79 0 0 1-8.63-3.07 19.5 19.5 0 0 1-6-6 19.79 19.79 0 0 1-3.07-8.67A2 2 0 0 1 4.11 2h3a2 2 0 0 1 2 1.72 12.84 12.84 0 0 0 .7 2.81 2 2 0 0 1-.45 2.11L8.09 9.91a16 16 0 0 0 6 6l1.27-1.27a2 2 0 0 1 2.11-.45 12.84 12.84 0 0 0 2.81.7A2 2 0 0 1 22 16.92z"></path></svg>
                </Box>
                <Text>9999999999</Text>
                </Stack></Link>
              <Link href={'#'}><Stack direction={'row'} alignItems={'center'}>
                <Box>
                <svg stroke="currentColor" fill="currentColor" strokeWidth="0" viewBox="0 0 12 16" height="1em" width="1em" xmlns="http://www.w3.org/2000/svg"><path fillRule="evenodd" d="M6 0C2.69 0 0 2.5 0 5.5 0 10.02 6 16 6 16s6-5.98 6-10.5C12 2.5 9.31 0 6 0zm0 14.55C4.14 12.52 1 8.44 1 5.5 1 3.02 3.25 1 6 1c1.34 0 2.61.48 3.56 1.36.92.86 1.44 1.97 1.44 3.14 0 2.94-3.14 7.02-5 9.05zM8 5.5c0 1.11-.89 2-2 2-1.11 0-2-.89-2-2 0-1.11.89-2 2-2 1.11 0 2 .89 2 2z"></path></svg>
                </Box>
                <Text>Mumbai</Text>
                </Stack></Link>
            </Stack>
            <Stack align={'flex-start'}>
              <ListHeader>Send message</ListHeader>
              <Stack direction={'column'}>
                <Textarea
                  placeholder={'Write a message'}
                  backgroundColor={'white'}
                  rows={5}
                  // width={'auto'}
                  border={0}
                  
                />
                <Button backgroundColor={'#A01E86'}
                 _hover={{ bgColor: '#7A146B' }}
                 color={'#fff'}
                width={'120px'}
                height={'40px'}
                fontWeight={500}
                fontSize={'18px'}
                >Send </Button>
              </Stack>s
            </Stack>
          </SimpleGrid>
        </Container>
      </Box>
      </ChakraProvider>
    );
  }