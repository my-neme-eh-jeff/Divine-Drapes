import React, { useEffect, useRef } from "react";
import { useState } from "react";
import {
  Box,
  ChakraProvider,
  Heading,
  SimpleGrid,
  Image,
  Button,
  Select,
  Input,
} from "@chakra-ui/react";
import "./Upload.css";
import Footer from "../Footer/Footer";
import Navbar from "../Navbar/Navbar";
import {
  Modal,
  ModalOverlay,
  ModalContent,
  ModalHeader,
  ModalFooter,
  ModalBody,
  ModalCloseButton,
  useDisclosure,
} from "@chakra-ui/react";
import Address from "./Address/Address";
import { useParams } from "react-router-dom";
import { Toast } from "@chakra-ui/react";
import { useToast } from "@chakra-ui/react";
import useAxiosPrivate from "../../Hooks/useAxiosPrivate";
import publicAxios from "../../Axios/publicAxios";
import { v4 as uuidv4 } from "uuid";
import useAuth from "./../../Hooks/useAuth";

function Buy() {
  const [body, setBody] = useState();
  const { auth, setAuth } = useAuth();
  const toast = useToast();
  const { productId } = useParams();
  const prodId = productId.split(":")[1];
  const [custText, setCustText] = useState("");
  const { isOpen, onOpen, onClose } = useDisclosure();
  const [pay, setPay] = useState();
  const privateAxios = useAxiosPrivate();
  const [files, setFiles] = useState(null);
  const [publicID, setPublicId] = useState([]);


  const getSingleProd = async () => {
    let config = {
      method: "GET",
      url: `product/viewProduct/${prodId}`,
    };
    try {
      const resp = await privateAxios(config);
      setBody(resp.data.data);
      console.log(body);
    } catch (err) {
      console.log(err);
    }
  };

  useEffect(() => {
    getSingleProd();
  }, []);

  const placeOrder = async () => {
    const formData = new FormData();

    formData.append("pID", prodId);
    formData.append("isCustPhoto", body.photo?.isCust);
    formData.append("isCustText", body.text?.isCust);
    formData.append("text", custText);
    formData.append("isCustColor", body.color?.isCust);
    formData.append("paymentStatus", "pending");
    formData.append("paymentType", pay);
    const imageFiles = document.getElementById("imagesOfCustomisation");
    let images = []
    for (const file of imageFiles.files) {
      const formImage = new FormData();
      formImage.append("file", file);
      //current date in format dd-mm-yyyy
      const date = new Date().toLocaleDateString().split("/").reverse();
      formImage.append("public_id", `${date} ${uuidv4()}`);
      formImage.append("folder", "orderImages");
      formImage.append("upload_preset", import.meta.env.VITE_UPLOAD_PRESET);

      try {
        const url =
          "https://api.cloudinary.com/v1_1/" +
          import.meta.env.VITE_CLOUD_NAME +
          "/image/upload";
        const resp = await publicAxios.post(url, formImage);
        console.log(resp.data);
        setPublicId((prev) => [...prev, resp.data.public_id]);
        images.push(resp.data.secure_url)
        // alert("WOW UPLAODED 😄"); 
      } catch (err) {
        console.log(err);
        alert("There was an error in uploading the iamge please try again!");
        return;
      }
    }
    formData.append("files", images);

    const config = {
      method: "POST",
      url: "user/orderWithImages",
      data: formData,
    };

    try {
      await privateAxios.request(config);
      alert("Order placed successfully");
    } catch (err) {
      console.log(err);
    }
  };


  return (
    <div>
      <ChakraProvider>
        <Navbar />
        {body && (
          <Box className="productbody">
            <br />
            <Heading className="namehere">{body.category}</Heading>
            <br />
            <Box height={"auto"} className="mainpro">
              <SimpleGrid
                h="auto"
                w="auto"
                columns={{ base: 1, md: 3 }}
                gap={15}
              >
                <Box
                  className="Box"
                  display={"flex"}
                  justifyContent={"center"}
                  alignItems={"center"}
                  alignSelf={"center"}
                >
                  <Image
                    boxSize="280px"
                    objectFit="cover"
                    src={body.photo.picture[0] || ""}
                    alt="Dan Abramov"
                  />
                </Box>
                <Box
                  className="Box"
                  display={"flex"}
                  justifyContent={"center"}
                  alignItems={"left"}
                  flexWrap={"center"}
                  flexDirection={"column"}
                >
                  <p>
                    <Heading fontSize={28} fontWeight={700}>
                      {body.name}
                    </Heading>
                  </p>
                  <p>{body.description}</p>
                  <br />
                  <p>
                    <Heading fontSize={24} fontWeight={700}>
                      ₹ {body?.cost?.value || "123"}
                    </Heading>
                  </p>
                  <br />
                  <div className="image-uploader">
                    <label htmlFor="upload-input" className="upload-label">
                      <span className="upload-text">
                        Upload your customization
                      </span>
                      <input
                        type="file"
                        id="imagesOfCustomisation"
                        multiple={true}
                        accept="image/*"
                        disabled={body.photo.isCust === false}
                      />
                    </label>
                    {/* {files.length > 0 && (
                      <div className="preview-images">
                        {files.map((file, index) => {
                          console.log(file);    
                          // <img
                          //   key={index}
                          //   src={image}
                          //   alt={`Preview of image ${index}`}
                          //   className="preview-image"
                          // />
                        })}
                      </div>
                    )} */}
                  </div>
                  <br />
                  <Heading fontSize={24} fontWeight={700}>
                    Text Customization
                  </Heading>
                  <Input
                    value={custText}
                    disabled={body.text?.isCust === false}
                    onChange={(e) => {
                      setCustText(e.target.value);
                    }}
                    placeholder="Enter your Text"
                  />

                  <br />
                  <Box
                    display={"flex"}
                    justifyContent={"space-around"}
                    width={"auto"}
                  >
                    <Button onClick={onOpen}>Shipping Address</Button>

                    <Modal isOpen={isOpen} onClose={onClose}>
                      <ModalOverlay />
                      <ModalContent>
                        <ModalHeader>Shipping Addresses</ModalHeader>
                        <ModalCloseButton />
                        <ModalBody>
                          <Address />
                        </ModalBody>

                        <ModalFooter>
                          <Button colorScheme="blue" mr={3} onClick={onClose}>
                            Close
                          </Button>
                          <Button
                            variant="ghost"
                            backgroundColor={"#F7BC62"}
                            _hover={{ color: "black" }}
                          >
                            Save & proceed
                          </Button>
                        </ModalFooter>
                      </ModalContent>
                    </Modal>

                    <Select
                      id="payment"
                      value={pay}
                      placeholder="Paymeny method"
                      width={"12vw"}
                      onChange={(e) => setPay(e.target.value)}
                    >
                      <option value="cod">Cash On Delivery</option>
                      <option value="card">Credit/Debit Card</option>
                      <option value="net banking">Net banking</option>
                      <option value="UPI">
                        UPI (G-pay , paytm , phonePay)
                      </option>
                    </Select>
                  </Box>
                  {pay == "card" ? (
                    <div className="modal">
                      <form className="form">
                        <div className="separator">
                          <hr className="line" />
                          <p>Pay using Credit/Debit card</p>
                          <hr className="line" />
                        </div>
                        <div className="credit-card-info--form">
                          <div className="input_container">
                            <label
                              htmlFor="password_field"
                              className="input_label"
                            >
                              Card holder full name
                            </label>
                            <input
                              id="password_field"
                              className="input_field"
                              type="text"
                              name="input-name"
                              title="Inpit title"
                              placeholder="Enter your full name"
                            />
                          </div>
                          <div className="input_container">
                            <label
                              htmlFor="password_field"
                              className="input_label"
                            >
                              Card Number
                            </label>
                            <input
                              id="password_field"
                              className="input_field"
                              type="number"
                              name="input-name"
                              title="Inpit title"
                              placeholder="0000 0000 0000 0000"
                            />
                          </div>
                          <div className="input_container">
                            <label
                              htmlFor="password_field"
                              className="input_label"
                            >
                              Expiry Date / CVV
                            </label>
                            <div className="split">
                              <input
                                id="password_field"
                                className="input_field"
                                type="text"
                                name="input-name"
                                title="Expiry Date"
                                placeholder="01/23"
                              />
                              <input
                                id="password_field"
                                className="input_field"
                                type="number"
                                name="cvv"
                                title="CVV"
                                placeholder="CVV"
                              />
                            </div>
                          </div>
                        </div>
                      </form>
                    </div>
                  ) : pay == "net banking" ? (
                    <>
                      <br />
                      <Select width={"auto"} placeholder="Select your bank">
                        <option value="BOB">Bank of Baroda</option>
                        <option value="AXIS">Axis Bank</option>
                        <option value="HDFC">HDFC</option>
                      </Select>
                    </>
                  ) : (
                    <p></p>
                  )}
                  <br />
                  <Box
                    textAlign={"center"}
                    justifyContent={"center"}
                    display={"flex"}
                  >
                    <Button
                      backgroundColor={"#A01E86"}
                      color={"white"}
                      onClick={placeOrder}
                      _hover={{
                        backgroundColor: "#A01E86",
                        color: "black",
                      }}
                      display={"flex"}
                      justifyContent={"center"}
                    >
                      Buy Now
                    </Button>
                  </Box>
                </Box>
              </SimpleGrid>
            </Box>
          </Box>
        )}

        <br />
        <Footer />
      </ChakraProvider>
    </div>
  );
}

export default Buy;
