import { useState } from "react";
import {
  ChakraProvider,
  Button,
  SimpleGrid,
  GridItem,
  AlertDialog,
  AlertDialogOverlay,
  AlertDialogContent,
  AlertDialogHeader,
  AlertDialogBody,
  AlertDialogFooter,
  useDisclosure,
} from "@chakra-ui/react";
import { CloseIcon } from "@chakra-ui/icons";

const categories = [
  "Mugs",
  "Paper Weight",
  "Coasters",
  " Hair Comb",
  "Envelop",
  "Diary",
  "Folders",
  "Study Desk",
  "Sequence Bag",
  "Sash",
  "T-Shirts",
  "Greetings Card",
  "Puzzles",
  "Luggage Tags",
  "Steel Crockery",
  "Locket & Keychain",
  "Magnet",
  "Photo Frames",
  "Pen & Pencil",
  "Bottles",
  "Cube",
  "Badges",
  "Play Card",
  "Calendars",
  "Writing Pads",
  "Crayons",
  "Sequence Pouch",
  "Pillows",
  "Cap",
  "Surprise Box",
  "Clock",
  "Passport Covers",
  "Pen Drive",
  "Smiley Table",
  "Key Chains",
  "Mobile Covers",
  "Pen Stand",
  "Wallets",
  "Office Products",
];

const Categories = () => {
  const [selected, setSelected] = useState([]);
  const { isOpen, onOpen, onClose } = useDisclosure();

  // const handleSelected = (item) => {
  //   setSelected(selected => selected.concat(item))
  // }
  const handleSelected = (item) => {
    setSelected((prevSelected) => new Set(prevSelected).add(item));
  };

  const handleRemove = (item) => {
    const updatedSelected = new Set(selected);
    updatedSelected.delete(item);
    setSelected(updatedSelected);
  };

  var chars = new Set(selected);

  return (
    <ChakraProvider>
      <Button bgColor={"#fff"} onClick={onOpen}>
        Categories
      </Button>

      <AlertDialog isOpen={isOpen}>
        <AlertDialogOverlay>
          <AlertDialogContent
            maxW="1300px"
            boxShadow={
              "-4px -4px 6px rgba(0, 0, 0, 0.25), 4px 4px 10px rgba(0, 0, 0, 0.25)"
            }
          >
            <AlertDialogHeader fontSize="lg" fontWeight="bold">
              Selected
              <Button float="right" bgColor={"#fff"} onClick={onClose}>
                <CloseIcon w="4" h="4" />
              </Button>
            </AlertDialogHeader>

            <AlertDialogBody>
              {Array.from(chars)?.map((item, index) => (
                <Button
                  border="1px"
                  bgColor={"#f7bc62"}
                  p="0 2% 0 2%"
                  key={index}
                  m="0% 0 1% 0.8%"
                  onClick={() => handleRemove(item)}
                >
                  {item} <CloseIcon w="3" h="3" ml='5%'/>
                </Button>
              ))}
            </AlertDialogBody>
            <AlertDialogHeader fontSize="lg" fontWeight="bold">
              All Categories
            </AlertDialogHeader>
            <AlertDialogBody>
              <SimpleGrid
                columns={[2, null, 8]}
                columnGap={[2, null, 4]}
                rowGap={[2, null, 6]}
              >
                {categories?.map((items, index) => (
                  <GridItem key={index}>
                    <Button
                      border={"1px"}
                      bgColor={"#fff"}
                      width={"150px"}
                      onClick={() => handleSelected(items)}
                    >
                      {items}
                    </Button>
                  </GridItem>
                ))}
              </SimpleGrid>
            </AlertDialogBody>
            <AlertDialogFooter>
              <Button bgColor={"#f7bc62"} onClick={onClose} width={"120px"}>
                Apply
              </Button>
            </AlertDialogFooter>
          </AlertDialogContent>
        </AlertDialogOverlay>
      </AlertDialog>
    </ChakraProvider>
  );
};

export default Categories;
