import { ChakraProvider, GridItem, SimpleGrid, Flex, Stack, Heading, Text, Button, Image } from '@chakra-ui/react'
import { useState, useEffect } from 'react'
import axios from 'axios'
import Navbar from './Navbar/Navbar';
import { ArrowBackIcon } from '@chakra-ui/icons'
import FavoriteBorderIcon from '@mui/icons-material/FavoriteBorder';
import FavoriteIcon from '@mui/icons-material/Favorite';
import { useLocation, useNavigate } from 'react-router-dom';
import privateAxios from '../Axios/privateAxios';
import useAuth from "./../Hooks/useAuth";
import { Link } from 'react-router-dom';

const AppliedCategory = () => {
    
    const [products, setProducts] = useState([]);
    const [favIcon, setFavIcon] = useState(false);
    const navigate = useNavigate();
    const [loading, setLoading] = useState(false);
    const location = useLocation();
    const searchParams = new URLSearchParams(location.search);
    const selectedCategories = searchParams.get("selected"); 
    const selected = selectedCategories ? selectedCategories.split(",") : [];
    console.log(selected[0])
    const { auth, setAuth } = useAuth();
    const isLogin = auth?.accessToken;
    console.log(isLogin);
    useEffect(() => {
        let config = {
        method: 'get',
        maxBodyLength: Infinity,
        url: 'https://divine-drapes.onrender.com/product/categoryWise/'+selected[0],
        headers: { 
            'Authorization': 'Bearer '+isLogin
        }
        };

        async function makeRequest() {
        setLoading(true)
        try {
            const response = await privateAxios.request(config);
            console.log((response.data));
            setProducts(response.data.data);
        }
        catch (error) {
            console.log(error);
        }
        finally {
            setLoading(false)
        }
        }

        makeRequest();

    },[])
    const addtocart=(id)=>{
        let config = {
        method: 'post',
        maxBodyLength: Infinity,
        url: 'https://divine-drapes.onrender.com/user/addCart/'+id,
        headers: { 
            'Authorization': 'Bearer '+isLogin,
        }
        };

        async function makeRequest() {
        try {
            const response = await axios.request(config);
            console.log((response.data));
        }
        catch (error) {
            console.log(error);
            if(error.response.data){
                alert(error.response.data.message);
            }
        }
        }

makeRequest();

    }
    return (
    <ChakraProvider>
        <Navbar />
            <Heading pt={['15%', null, '6%']} ml='7%'>
                <ArrowBackIcon onClick={() => navigate('/')} 
                _hover={{ cursor: 'pointer'}}
                mr={'2%'}
                /> 
                Mugs
            </Heading>  
            <Flex justifyContent={'space-around'} m='2% 0'>
            <SimpleGrid columns={{sm: 1, md: 4}} rowGap={10} columnGap={20}>
            {products.map((prod,index) => (
                
                <GridItem width={'250px'} key={index}>
                    <Link to={`/product/:${prod._id}`} key={index}>
                    <Image
                        src='https://images.unsplash.com/photo-1555041469-a586c61ea9bc?ixlib=rb-4.0.3&ixid=MnwxMjA3fDB8MHxwaG90by1wYWdlfHx8fGVufDB8fHx8&auto=format&fit=crop&w=1770&q=80'
                        alt='Green double couch with wooden legs'
                        borderRadius='lg'
                        width={'240px'}
                        height={'240px'}
                        alignSelf='center'
                    />       
                    </Link>             
                        <Flex justifyContent={'space-between'} mb='3%'>
                            <Stack mt='4' spacing=''>
                                <Heading size='md'>{prod.name}</Heading>
                                <Text fontSize='sm' fontWeight={550}>
                                    Customizable: {prod.photo.isCust? <span>Photo</span>:<span></span>}{prod.text.isCust? <span>,Text</span>:<span></span>}
                                </Text>
                            </Stack>
                            <Stack mt='6' spacing='1' mr='3'>
                                <Text fontSize={'xl'} fontWeight='bold'>₹/Rs.{prod.cost.value}</Text>
                            </Stack>
                        </Flex>
                        <Flex justifyContent={'space-between'}>
                            <Button 
                                bgColor={"#f7bc62"} 
                                p='0 12%' 
                                onClick={() => addtocart(prod._id)}
                                _hover={{ bgColor: "#e0a24e" }}
                            >
                                Add to Cart
                            </Button>
                        </Flex>
                </GridItem>
                
            ))}
            </SimpleGrid>                   
            </Flex>
    </ChakraProvider>
  )
}

export default AppliedCategory