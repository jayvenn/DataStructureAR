import { initializeApp } from "firebase/app";
import { getAnalytics } from "firebase/analytics";
// TODO: Add SDKs for Firebase products that you want to use
// https://firebase.google.com/docs/web/setup#available-libraries

// Your web app's Firebase configuration
// For Firebase JS SDK v7.20.0 and later, measurementId is optional
const firebaseConfig = {
    apiKey: "AIzaSyBITsEUt4E8yCNrRrZDRIW5_tX0znEEP4A",
    authDomain: "data-structure-ar.firebaseapp.com",
    projectId: "data-structure-ar",
    storageBucket: "data-structure-ar.appspot.com",
    messagingSenderId: "31373461832",
    appId: "1:31373461832:web:6166fd2a8f8e8db4ad4b7d",
    measurementId: "G-20BMNK5SMH"
};

// Initialize Firebase
const app = initializeApp(firebaseConfig);
const analytics = getAnalytics(app);