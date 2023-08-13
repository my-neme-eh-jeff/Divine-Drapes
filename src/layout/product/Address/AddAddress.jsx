import { Box, ChakraProvider, Text, VStack, SimpleGrid, GridItem, FormControl, FormLabel, Input, Select, Button } from "@chakra-ui/react"
import { ArrowBackIcon } from "@chakra-ui/icons"
import { useState } from 'react';
import { useNavigate } from "react-router-dom";
import { useEffect } from 'react';
import privateAxios from "../../../Axios/privateAxios";
import useAuth from "../../../Hooks/useAuth";
const AddAddress = () => {
    const initialStates = {addressOf: '', houseNumber: '', building: '', street: '', city: '', state: '', country: ''};
    const countries = ['India', 'Sri Lanka'];
    const states = ['Maharashtra', 'Gujarat'];
    const [formData, setFormData] = useState(initialStates);
    const { auth, setAuth } = useAuth();
    const isLogin = auth?.accessToken;
    console.log(isLogin);
    const navigate = useNavigate();

    const handleSubmit = () => {
        console.log(formData);
    }
    useEffect(() => {
            let config = {
              method: "GET",
              url: "user/profile",
            };
            async function makeRequest() {
              try {
                const response = await privateAxios.request(config);
                console.log(response.data.data.addresslist);
              } catch (error) {
                console.log(error);
              }
            }
            makeRequest();
          }, []);
    
    

  return (
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
                                <Input placeholder="Home, Office..." border='2px' value={formData.addressOf} onChange={(e) => setFormData({...formData, addressOf: e.target.value})}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={[2, null, 1]}>
                            <FormControl>
                                <FormLabel>Enter HouseNumber</FormLabel>
                                <Input placeholder="Enter HouseNumber" border='2px' value={formData.houseNumber} onChange={(e) => setFormData({...formData, houseNumber: e.target.value})}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Enter Building Name</FormLabel>
                                <Input placeholder="Enter Building Name" border='2px' value={formData.building} onChange={(e) => setFormData({ ...formData, building: e.target.value })}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Enter Street Name</FormLabel>
                                <Input placeholder="Enter Street Name" border='2px' value={formData.street} onChange={(e) => setFormData({ ...formData, street: e.target.value })}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Enter City Name</FormLabel>
                                <Input placeholder="Enter City Name" border='2px' value={formData.city} onChange={(e) => setFormData({ ...formData, city: e.target.value })}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={[2, null, 1]}>
                            <FormControl>
                                <FormLabel>Select State</FormLabel>
                                <Select placeholder='Select State' size='md' border='2px' value={formData.state} onChange={(e) => setFormData({ ...formData, state: e.target.value })}>
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
                                <Select placeholder='Select Country' size='md' border='2px' value={formData.country} onChange={(e) => setFormData({ ...formData, country: e.target.value })}>
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
  )
}

export default AddAddress;