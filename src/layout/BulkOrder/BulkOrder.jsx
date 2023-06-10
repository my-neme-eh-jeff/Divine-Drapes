import { Box, ChakraProvider, Text, VStack, SimpleGrid, GridItem, FormControl, FormLabel, Input, Select, Button, Flex } from "@chakra-ui/react"
import { ArrowBackIcon, ExternalLinkIcon } from "@chakra-ui/icons"
import { useState } from 'react';

const initialStates = {fname: '', lname: '', email: '', company: '', units: '', items: '', addinfo: ''};

const selected = ['mugs', 'locket'];

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
        <VStack>
        <Box 
            boxShadow='-5px -2px 6px 2px rgba(0, 0, 0, 0.25), 2px 5px 6px 2px rgba(0, 0, 0, 0.25)' 
            p='1% 15%'
            borderRadius={'20px'} 
            border='1px'
            m='5% 1% 0 0'>
                <VStack>
                    <Text color='#A01E86' fontWeight='700' fontSize='18px'>Have a bulk order ?</Text>
                    <Text color='#A01E86' fontWeight='500' fontSize='17px'>Fill the following details and we will get back to you</Text>
                    <SimpleGrid columns={2} columnGap={3} rowGap={2}>
                        <GridItem colSpan={[2, null, 1]}>
                            <FormControl>
                                <FormLabel>First Name</FormLabel>
                                <Input placeholder="First Name" border='2px' value={formData.fname} onChange={(e) => setFormData({...formData, fname: e.target.value})}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={[2, null, 1]}>
                            <FormControl>
                                <FormLabel>Last Name</FormLabel>
                                <Input placeholder="Last Name" border='2px' value={formData.lname} onChange={(e) => setFormData({...formData, lname: e.target.value})}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Email</FormLabel>
                                <Input placeholder="Enter your Email address" border='2px' type='email' value={formData.email} onChange={(e) => setFormData({ ...formData, email: e.target.value })}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Phone Number</FormLabel>
                                <Input placeholder="Enter your Phone number" border='2px' type='number' value={formData.phone} onChange={(e) => setFormData({ ...formData, phone: e.target.value })}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Company</FormLabel>
                                <Input placeholder="Enter your Company name" border='2px' value={formData.company} onChange={(e) => setFormData({ ...formData, company: e.target.value })}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={[2, null, 1]}>
                            <FormControl>
                                <FormLabel>Number of units</FormLabel>
                                <Input placeholder="Number" border='2px' type='number' value={formData.units} onChange={(e) => setFormData({ ...formData, units: e.target.value })}/>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={[2, null, 1]}>
                            <FormControl>
                                <FormLabel>Items selected</FormLabel>
                                <Select placeholder='Select item' size='md' border='2px' value={formData.items} onChange={(e) => setFormData({ ...formData, items: e.target.value })}>
                                    {selected.map(item => (
                                        <option key={item} value={item}>
                                            {item}
                                        </option>
                                    ))}
                                </Select>
                            </FormControl>
                        </GridItem>
                        <GridItem colSpan={2}>
                            <FormControl>
                                <FormLabel>Additional Info</FormLabel>
                                <Input placeholder="Additional Information" border='2px' value={formData.addinfo} onChange={(e) => setFormData({ ...formData, addinfo: e.target.value })}/>
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
        </VStack>
    </ChakraProvider>
  )
}

export default BulkOrder