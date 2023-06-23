import React, { useState } from 'react'
import {
    ChakraProvider,
    PopoverTrigger,
    PopoverContent,
    PopoverHeader,
    Button,
    PopoverBody,
    Popover,
    SimpleGrid,
    GridItem,
} from "@chakra-ui/react";
import { ChevronDownIcon, ChevronUpIcon, CloseIcon } from "@chakra-ui/icons";

const categories = ['Mugs', 'Paper Weight', 'Coasters', ' Hair Comb', 'Envelop', 'Diary', 'Folders',
                    'Study Desk', 'Sequence Bag', 'Sash', 'T-Shirts', 'Greetings Card', 'Puzzles',
                    'Luggage Tags', 'Steel Crockery', 'Locket & Keychain', 'Magnet', 'Photo Frames',
                    'Pen & Pencil', 'Bottles', 'Cube', 'Badges', 'Play Card', 'Calendars', 'Writing Pads', 
                    'Crayons', 'Sequence Pouch', 'Pillows', 'Cap', 'Surprise Box', 'Clock', 'Passport Covers',
                    'Pen Drive', 'Smiley Table', 'Key Chains', 'Mobile Covers', 'Pen Stand', 'Wallets', 'Office Products']

const Categories = () => {

    const initialFocusRef = React.useRef();
    const [downIcon, setDownIcon] = useState(false);
    const [selected, setSelected] = useState([]);

    // var selected = ['hello', 'hii'];


    const handleSelected = (item) => {
      setSelected(selected => selected.concat(item))
    }
    
    var chars = new Set(selected);
    console.log([chars])

  return (
    <ChakraProvider>
        <Popover
              initialFocusRef={initialFocusRef}
              placement="bottom"
              closeOnBlur={false}
            >
              <PopoverTrigger>
                <Button bgColor={'#fff'} onClick={() => setDownIcon(!downIcon)}>
                  Categories {downIcon ? <ChevronUpIcon /> : <ChevronDownIcon /> }
                </Button>
              </PopoverTrigger>
              <PopoverContent
                boxShadow={'-4px -4px 6px rgba(0, 0, 0, 0.25), 4px 4px 10px rgba(0, 0, 0, 0.25)'}
                width={['100%', null, '100%']}
                p='2%'
                position='relative'
                right={['0', null, '5%']}
              >
                <PopoverHeader pt={4} fontWeight="bold" border="0">
                  Selected
                  <Button bgColor={'#f7bc62'} border='1px' float='right' width='120px'>Apply</Button>
                </PopoverHeader>
                <PopoverBody>
                  {Array.from(chars)?.map((item, index) => (
                  <Button border='1px' bgColor={'#f7bc62'} p='0 1% 0 1%' key={index} mr='1%' >
                        {item} <CloseIcon w='3' h='3' ml='10%' onClick={(e) => e.target.parentNode.remove(item)}/>
                  </Button>
                  ))}
                </PopoverBody>
                <PopoverHeader pt={4} fontWeight="bold" border="0">
                  All categories
                </PopoverHeader>
                <PopoverBody>
                    <SimpleGrid columns={[2, null, 8]} columnGap={[2, null, 4]} rowGap={[2, null, 6]}>
                      {categories?.map((items, index) => (
                        <GridItem key={index}><Button border={'1px'} bgColor={'#fff'} width={'150px'}
                        onClick={() => handleSelected(items)}>{items}</Button></GridItem>
                      ))}
                    </SimpleGrid>
                </PopoverBody>
              </PopoverContent>
            </Popover>
    </ChakraProvider>
  )
}

export default Categories