import { useEffect } from 'react';

export default function MainForm({ navigation }) {
  useEffect(() => {
    const unsubscribe = navigation.addListener('focus', () => {
      navigation.replace('Groups');
    });
    return unsubscribe;
  }, [navigation]);
  
  return null;
}
