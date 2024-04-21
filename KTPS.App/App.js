import { createDrawerNavigator, DrawerContentScrollView, DrawerItemList, DrawerItem } from '@react-navigation/drawer';
import { NavigationContainer } from '@react-navigation/native';
import { createStackNavigator } from '@react-navigation/stack';
import Login from "./components/Login";
import Register from "./components/Register";
import MainForm from "./components/Main";
import AsyncStorage from "@react-native-async-storage/async-storage";
import FriendsForm from './components/Friends';
import FindFriends from './components/FindFriends';

const Drawer = createDrawerNavigator();
const Stack = createStackNavigator();

const MainFormStackScreen = () => (
  <Stack.Navigator screenOptions={{ headerShown: false }}>
    <Stack.Screen name="MainForm" component={MainForm} />
  </Stack.Navigator>
);

const FriendsStackScreen = () => (
  <Stack.Navigator initialRouteName="FriendsPage" screenOptions={{ headerShown: false }}>
    <Stack.Screen name="FriendsPage" component={FriendsForm} />
    <Stack.Screen name="FindFriends" component={FindFriends} />
  </Stack.Navigator>
);

const CustomDrawerContent = (props) => (
  <DrawerContentScrollView {...props}>
    <DrawerItemList {...props} />
    <DrawerItem
      label="Logout"
      onPress={async () => {
        props.navigation.closeDrawer();
        await AsyncStorage.removeItem('rememberedUserId');
        await AsyncStorage.removeItem('userId');
        props.navigation.replace("Login");
      }}
    />
  </DrawerContentScrollView>
);

const App = () => {
  return (
    <NavigationContainer>
      <Stack.Navigator initialRouteName="Login" screenOptions={{ headerShown: false }}>
        <Stack.Screen name="Login" component={Login} />
        <Stack.Screen name="Register" component={Register} />
        <Stack.Screen name="MainForm" component={MainFormDrawer} />
      </Stack.Navigator>
    </NavigationContainer>
  );
}

const MainFormDrawer = () => (
  <Drawer.Navigator drawerContent={props => <CustomDrawerContent {...props} />}>
    <Drawer.Screen name="Home" component={MainFormStackScreen} />
    <Drawer.Screen name="Friends" component={FriendsStackScreen} />
    {/* NOTIFICATIONS, PROFILE */}
  </Drawer.Navigator>
);

export default App;
