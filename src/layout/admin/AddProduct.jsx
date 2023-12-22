import {
  Center,
  ChakraProvider,
  Container,
  Heading,
  Stack,
  VStack,
  Input,
  Box,
  HStack,
  SimpleGrid,
  Button,
  TableContainer,
  Table,
  Tbody,
  Tr,
  Td,
  InputGroup,
  InputRightAddon,
  Textarea,
  GridItem,
  FormControl,
} from "@chakra-ui/react";
import React, { useEffect, useRef, useState } from "react";
import { v4 as uuidv4 } from "uuid";
import publicAxios from "../../Axios/publicAxios";
import useAxiosPrivate from "../../Hooks/useAxiosPrivate";

function AddProduct() {
  const [productName, setProductName] = useState();
  const [description, setDescription] = useState();
  const [quantity, setQuantity] = useState();
  const [cost, setCost] = useState();
  const [cust, setCust] = useState();
  const [imageCust, setImageCust] = useState(false);
  const [colorCust, setColorCust] = useState(false);
  const [textCust, setTextCust] = useState(false);
  const fileInputRef = useRef(null);
  const [colorInp, setColorInp] = useState();
  const [colors, setColors] = useState([]);
  const [category, setCategory] = useState();
  const privateAxios = useAxiosPrivate();
  const [publicID, setPublicID] = useState([]);
  const [loading, setLoading] = useState(false);

  const handleColorAdd = (newColor) => {
    setColors([...colors, newColor]);
  };

  const handleColorEdit = (index, updatedColor) => {
    const newColors = [...colors];
    newColors[index] = updatedColor;
    setColors(newColors);
  };

  const handleColorRemove = (index) => {
    const newColors = colors.filter((_, i) => i !== index);
    setColors(newColors);
  };

  useEffect(() => {
    // Your code that depends on the updated state
    console.log(publicID);
  }, [publicID]); // Dependency array ensures this effect runs after each update to publicId
  

  const resetInputFieldsAfterUploading = () => {
    setProductName("");
    setDescription("");
    setQuantity("");
    setCost("");
    setCategory("");
    setImageCust(false);
    setColorCust(false);
    setTextCust(false);
    setColors([]);
    setColorInp("");
    setPublicID([]);
  };

  const addnewprod = async () => {
    setLoading(true);
    const imageFiles = document.getElementById("imagesOfProduct");
    let images =[]
    for (const file of imageFiles.files) {
      const formImage = new FormData();
      formImage.append("file", file);
      formImage.append("public_id", `${productName} ${uuidv4()}`);
      formImage.append("folder", "products");
      formImage.append("upload_preset", import.meta.env.VITE_UPLOAD_PRESET);

      try {
        const url =
          "https://api.cloudinary.com/v1_1/" +
          import.meta.env.VITE_CLOUD_NAME +
          "/image/upload";
        const resp = await publicAxios.post(url, formImage);
        console.log(resp.data.secure_url);
        images.push(resp.data.secure_url)
        setPublicID((prev) => [...prev, resp.data.secure_url]);
        // resetInputFieldsAfterUploading()
      } catch (err) {
        console.log(err);
        alert("There was an error in uploading the iamge please try again!");
        return;
      }
    }
    try {
      console.log(publicID)
      const data = {
        name: productName,
        description: description,
        category: category,
        quantity: quantity,
        cost: {
          currency: "INR",
          value: cost,
        },
        photo: {
          isCust: imageCust,
          picture: images,
        },
        text: {
          isCust: textCust,
        },
        color: {
          isCust: colorCust,
          color: colors,
        },
      };
      const config = {
        method: "post",
        url: "admin/addProduct",
        data: data,
      };
      const response = await privateAxios.request(config);
      console.log(response.data);
      alert("WOW UPLAODED 😄");
    } catch (error) {
      console.log(error);
    }
    setLoading(false);
  };

  return (
    <div>
      <ChakraProvider>
        <Center>
          <Heading>Add Products</Heading>
        </Center>
        <br />
        <Container
          height={"auto"}
          border={"1px solid #000"}
          boxShadow={
            "2px 5px 6px 2px rgba(0, 0, 0, 0.25), -5px -2px 6px 2px rgba(0, 0, 0, 0.25)"
          }
          width={"auto"}
        >
          <br />
          <Stack spacing={6}>
            <div className="image-uploader">
              <label htmlFor="upload-input" className="upload-label">
                <span className="upload-text">
                  Upload your Product Image here
                </span>
                <input
                  id="imagesOfProduct"
                  ref={fileInputRef}
                  type="file"
                  accept="image/*"
                  required
                  multiple
                  name="files"
                />
              </label>
            </div>
            <Heading fontSize={24} fontWeight={700}>
              Product Name
            </Heading>
            <Input
              value={productName}
              onChange={(e) => {
                setProductName(e.target.value);
                // console.log(productName);
              }}
              placeholder="Enter your Product Name"
            />
            <Input
              value={category}
              onChange={(e) => {
                setCategory(e.target.value);
                // console.log(category);
              }}
              placeholder="Enter the Category"
            />
            <Textarea
              placeholder="Enter description"
              value={description}
              onChange={(e) => {
                setDescription(e.target.value);
                // console.log(description);
              }}
            />
            <SimpleGrid columns={2} columnGap={3} rowGap={2}>
              <GridItem colSpan={[2, null, 1]}>
                <FormControl>
                  <Input
                    placeholder="Enter Quantity"
                    type="number"
                    value={quantity}
                    onChange={(e) => {
                      setQuantity(e.target.value);
                      // console.log(quantity);
                    }}
                  />
                </FormControl>
              </GridItem>
              <GridItem colSpan={[2, null, 1]}>
                <FormControl>
                  <Input
                    placeholder="Enter Cost"
                    type="number"
                    value={cost}
                    onChange={(e) => setCost(e.target.value)}
                  />
                </FormControl>
              </GridItem>
            </SimpleGrid>
            <Heading fontSize={24} fontWeight={700}>
              Customization
            </Heading>
            <Box>
              <div className="containerr">
                <form>
                  <SimpleGrid columns={{ md: 2, base: 1 }}>
                    <label>
                      <input
                        type="radio"
                        value={"yes"}
                        onChange={(e) => setCust(e.target.value)}
                        name="radio"
                      />
                      <span>Yes</span>
                    </label>
                    <label>
                      <input
                        type="radio"
                        value={"no"}
                        onChange={(e) => setCust(e.target.value)}
                        name="radio"
                      />
                      <span>No</span>
                    </label>
                  </SimpleGrid>
                  <br />
                </form>
              </div>
            </Box>
            {cust == "yes" ? (
              <>
                <Heading fontSize={24} fontWeight={700}>
                  Select your Customizations
                </Heading>
                <div className="containerr">
                  <form>
                    <SimpleGrid columns={{ md: 3, base: 1 }}>
                      <label>
                        {/* <input type="radio" value={true} onChange={e => setImageCust(e.target.value)} name="radio" /> */}
                        <input
                          type="checkbox"
                          checked={imageCust}
                          onChange={(e) =>
                            setImageCust((prevValue) => !prevValue)
                          }
                        />
                        <span>Image</span>
                      </label>
                      <label>
                        {/* <input type="radio" value={true} onChange={e => setColorCust(e.target.value)} name="radio" /> */}
                        <input
                          type="checkbox"
                          checked={colorCust}
                          onChange={(e) =>
                            setColorCust((prevValue) => !prevValue)
                          }
                        />
                        <span>Color</span>
                      </label>
                      <label>
                        {/* <input type="radio" value={true} onChange={e => setTextCust(e.target.value)} name="radio" /> */}
                        <input
                          type="checkbox"
                          checked={textCust}
                          onChange={(e) =>
                            setTextCust((prevValue) => !prevValue)
                          }
                        />
                        <span>Text</span>
                      </label>
                    </SimpleGrid>
                    <br />
                  </form>
                </div>
              </>
            ) : (
              <></>
            )}
            {colorCust ? (
              <>
                <div>
                  <h2>Add your colors</h2>
                  <InputGroup>
                    <Input
                      value={colorInp}
                      onChange={(e) => {
                        setColorInp(e.target.value);
                      }}
                      placeholder="Enter your Color Availabe"
                    />
                    <InputRightAddon>
                      <Button onClick={() => handleColorAdd(colorInp)}>
                        Add Color
                      </Button>
                    </InputRightAddon>
                  </InputGroup>
                  <ul>
                    <TableContainer>
                      <Table variant={"simple"}>
                        <Tbody>
                          {colors.map((color, index) => (
                            <Tr key={index}>
                              <Td fontWeight={800}>{color}</Td>
                              <Td>
                                <Button
                                  onClick={() =>
                                    handleColorEdit(
                                      index,
                                      prompt("Enter new color:")
                                    )
                                  }
                                >
                                  Edit
                                </Button>
                              </Td>
                              <Td>
                                <Button
                                  onClick={() => handleColorRemove(index)}
                                >
                                  Remove
                                </Button>
                              </Td>
                            </Tr>
                          ))}
                        </Tbody>
                      </Table>
                    </TableContainer>
                  </ul>
                </div>
              </>
            ) : (
              <></>
            )}
          </Stack>
          <br />
          <Center>
            <Button
              width={"400px"}
              background={"#F7BC62"}
              _hover={{
                background: "#F7BC62",
              }}
              isLoading={loading}
              onClick={addnewprod}
            >
              Add Product
            </Button>
          </Center>
          <br />
        </Container>
      </ChakraProvider>
    </div>
  );
}

export default AddProduct;
