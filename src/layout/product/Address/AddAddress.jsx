import { Box, ChakraProvider, Text, VStack, SimpleGrid, GridItem, FormControl, FormLabel, Input, Select, Button } from "@chakra-ui/react"
import { ArrowBackIcon, InfoIcon } from "@chakra-ui/icons"
import { useState } from 'react';
import { useNavigate } from "react-router-dom";
import { useEffect } from 'react';
import privateAxios from "../../../Axios/privateAxios";
import { ToastContainer, toast } from 'react-toastify';
import 'react-toastify/dist/ReactToastify.css';
import useAuth from "../../../Hooks/useAuth";
    const AddAddress = () => {
        const countries = ['India', 'Sri Lanka'];
    const states = ['Maharashtra', 'Gujarat'];
    // const initialStates = {addressOf: ' ', houseNumber: ' ', building: ' ', street: ' ', city: ' ', state: states, country: countries};
    // const [formData, setFormData] = useState(initialStates);

    const [addressOf, setAddressOf] = useState('');
    const [houseNumber, setHouseNumber] = useState('');
    const [building, setBuilding] = useState('');
    const [street, setStreet] = useState('');
    const [city, setCity] = useState('');
    const [state, setState] = useState('');
    const [country, setCountry] = useState('');
    // console.log(initialStates);
    const navigate = useNavigate();
    const { auth, setAuth } = useAuth();
    const isLogin = auth?.accessToken;
    const handleSubmit = () => {
        //add all the address data to form data
        const formData = {addressOf, houseNumber, building, street, city, state, country};
        console.log(formData);
        const formDataWithoutId = { ...formData };
        delete formDataWithoutId._id;
        console.log("hi:",formDataWithoutId);
            let data = {
                addressList:[formDataWithoutId]
            }
            console.log(data);
            let config = {
            method: 'put',
            maxBodyLength: Infinity,
            url: 'https://divine-drapes.onrender.com/user/editUserInfo',
            headers: { 
                'Authorization': 'Bearer '+isLogin, 
                'Content-Type': 'application/json'
            },
            data : data
            };

            async function makeRequest() {
            try {
                const response = await privateAxios.request(config);
                console.log((response.data));
                toast.success("Updated succesfully", { containerId: "bottom-left" });
            }
            catch (error) {
                console.log(error);
            }
            }

            makeRequest();

    }
    useEffect(() => {
            let config = {
              method: "GET",
              url: "https://divine-drapes.onrender.com/user/profile",
              headers:{
                Authorization:"Bearer "+isLogin
              }
            };
            async function makeRequest() {
              try {
                const response = await privateAxios.request(config);
                console.log(response.data.data.addressList);
                // setFormData(response.data.data.addressList[0]);
              } catch (error) {
                console.log(error);
              }
            }
            makeRequest();
          }, []);
    
    

  return (
    <>
    <ChakraProvider>
        
         <Box pt={{base: '5%', md: '10%', lg: '6%'}} pb='4%'>
        <SimpleGrid columns={12} columnGap={3} m='1% 0 2% 10%'>
            <GridItem colSpan={[2, null, 1]}>
                <Button bgColor='#ffffff' onClick={() => navigate('/')}>{<ArrowBackIcon fontSize='20px'/>}</Button>
            </GridItem>
            <GridItem colSpan={[4, null, 2]}>
                <Text fontWeight='500' fontSize='18px'>Add Address</Text>
            </GridItem>
        </SimpleGrid>
        <VStack>
        <Box 
            boxShadow='-5px -2px 6px 2px rgba(0, 0, 0, 0.25), 2px 5px 6px 2px rgba(0, 0, 0, 0.25)' 
            p='1% 15%'
            borderRadius={'20px'} 
            border='1px'
            m='0 1%'>
                <VStack>
                    <Text color='#A01E86' fontWeight='700' fontSize='18px'>Add New Address</Text>
                    <Text color='#A01E86' fontWeight='500' fontSize='17px' align={'center'}>Fill the following details to add new address</Text>
                    <SimpleGrid columns={2} columnGap={3} rowGap={2}>
                        <GridItem colSpan={[2, null, 1]}>
                            <FormControl>
                                <FormLabel>It is AddressOf</FormLabel>
                                <Input placeholder="Home, Office..." border='2px' value={addressOf} onChange={(e) => setAddressOf(e.target.value)}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={[2, null, 1]}>
                            <FormControl>
                                <FormLabel>Enter HouseNumber</FormLabel>
                                <Input placeholder="Enter HouseNumber" border='2px' value={houseNumber} onChange={(e) => setHouseNumber(e.target.value)}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Enter Building Name</FormLabel>
                                <Input placeholder="Enter Building Name" border='2px' value={building} onChange={(e) => setBuilding(e.target.value )}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Enter Street Name</FormLabel>
                                <Input placeholder="Enter Street Name" border='2px' value={street} onChange={(e) => setStreet( e.target.value )}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Enter City Name</FormLabel>
                                <Input placeholder="Enter City Name" border='2px' value={city} onChange={(e) => setCity(e.target.value )}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={[2, null, 1]}>
                            <FormControl>
                                <FormLabel>Select State</FormLabel>
                                <Select placeholder='Select State' size='md' border='2px' value={state} onChange={(e) => setState(e.target.value )}>
                                    {states.map(item => (
                                        <option key={item} value={item}>
                                            {item}
                                        </option>
                                    ))}
                                </Select>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={[2, null, 1]}>
                            <FormControl>
                                <FormLabel>Select Country</FormLabel>
                                <Select placeholder='Select Country' size='md' border='2px' value={country} onChange={(e) => setCountry(e.target.value )}>
                                    {countries.map(item => (
                                        <option key={item} value={item}>
                                            {item}
                                        </option>
                                    ))}
                                </Select>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2} m='5% 0'>
                            <FormControl>
                                <Button 
                                bgColor='#f7bc62' 
                                width='100%' 
                                onClick={handleSubmit} 
                                _hover={{ bgColor: "#e0a24e" }}
                                >
                                    Add Address
                                </Button>
                            </FormControl>
                        </GridItem>
                    </SimpleGrid>
                </VStack>

        </Box>
        </VStack>
        </Box>
        
       
        
    </ChakraProvider>
    <ToastContainer position="bottom-left" />
    </>
  )
}

export default AddAddress;