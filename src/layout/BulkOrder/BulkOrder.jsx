import { Box, ChakraProvider, Text, VStack, SimpleGrid, GridItem, FormControl, FormLabel, Input, Select, Button, Flex } from "@chakra-ui/react"
import { ArrowBackIcon, ExternalLinkIcon } from "@chakra-ui/icons"
import { useState } from 'react';

const initialStates = {fname: '', lname: '', email: '', company: '', units: '', items: '', addinfo: ''};

const BulkOrder = () => {

    const [formData, setFormData] = useState(initialStates);

    const handleSubmit = () => {
        console.log(formData);
    }

  return (
    <ChakraProvider>
        <Flex alignContent='space-between'>
            <Button bgColor='#ffffff'>{<ArrowBackIcon fontSize='20px'/>}</Button>
            <Text fontWeight='500' fontSize='18px'>Bulk Orders</Text>
        </Flex>
        <Box 
            boxShadow='dark-lg' 
            m='2% 21% 5%' 
            p='1% 15%'
            borderRadius={'20px'} 
            border='1px'>
                <VStack>
                    <Text color='#A01E86' fontWeight='700' fontSize='18px'>Have a bulk order ?</Text>
                    <Text color='#A01E86' fontWeight='500' fontSize='17px'>Fill the following details and we will get back to you</Text>
                    <SimpleGrid columns={2} columnGap={3} rowGap={2}>
                        <GridItem colSpan={1}>
                            <FormControl>
                                <FormLabel>First Name</FormLabel>
                                <Input placeholder="First Name" border='2px' value={formData.fname} onChange={(e) => setFormData.fname(e.target.value)}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={1}>
                            <FormControl>
                                <FormLabel>Last Name</FormLabel>
                                <Input placeholder="Last Name" border='2px'value={formData.lname} onChange={(e) => setFormData.lname(e.target.value)}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Email</FormLabel>
                                <Input placeholder="Enter your Email address" border='2px' type='email'/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Phone Number</FormLabel>
                                <Input placeholder="Enter your Phone number" border='2px' type='number'/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Company</FormLabel>
                                <Input placeholder="Enter your Company name" border='2px' />
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={1}>
                            <FormControl>
                                <FormLabel>Number of units</FormLabel>
                                <Input placeholder="Number" border='2px' type='number'/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={1}>
                            <FormControl>
                                <FormLabel>Items selected</FormLabel>
                                <Select placeholder='Select item' size='md' border='2px'/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Additional Info</FormLabel>
                                <Input placeholder="Additional Information" border='2px' />
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Upload any custom photo/logo</FormLabel>
                                <Button border='2px' variant='outlined' width='100%'>Upload {<ExternalLinkIcon/>}</Button>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2} m='5% 0'>
                            <FormControl>
                                <Button bgColor='#f7bc62' width='100%' onClick={handleSubmit}>Submit</Button>
                            </FormControl>
                        </GridItem>
                    </SimpleGrid>
                </VStack>

        </Box>
    </ChakraProvider>
  )
}

export default BulkOrder