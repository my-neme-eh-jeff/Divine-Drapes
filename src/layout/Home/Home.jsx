import { Flex, Text, Tabs, Tab } from '@chakra-ui/react';
import './Home.css';

const Home = () => {
  return (
    <Flex justifyContent='space-around'>
        <Text fontSize={38} fontWeight='700' color='#ffffff'>A wide variety of customizable gifts for your loved ones.</Text>
        <Tabs display='flex'>
            <Tab>One</Tab>
            <Tab>Two</Tab>
            <Tab>Three</Tab>
        </Tabs>
    </Flex>
  )
}

export default Home