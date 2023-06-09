import { Flex, Menu, Avatar, WrapItem, Link, MenuButton, Button, Wrap } from "@chakra-ui/react"
import { ChevronDownIcon } from '@chakra-ui/icons'
import { ChakraProvider } from '@chakra-ui/react'

const Navbar = () => {

  return (
    <ChakraProvider>
    <Flex h="75px" justifyContent='space-between' align='center' m='0 5%'>
        <Wrap>
        <Link href='/' fontSize={30} color='#A01E86' fontWeight='700'>Divine Drapes</Link>
        </Wrap>
        <Wrap>
            <Menu>
                <MenuButton bgColor='#fff' as={Button} rightIcon={<ChevronDownIcon />}>
                    Categories
                </MenuButton>
                <MenuButton bgColor='#fff' as={Button}>Bulk Orders</MenuButton>
                <MenuButton bgColor='#fff' as={Button}>Cart</MenuButton>
                <WrapItem>
                    <Avatar />
                </WrapItem>
            </Menu>
        </Wrap>
    </Flex>
    </ChakraProvider>
  )
}

export default Navbar