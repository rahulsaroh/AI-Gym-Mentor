import React, { useEffect } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion } from 'motion/react';
import { Dumbbell } from 'lucide-react';

export default function SplashScreen() {
  const navigate = useNavigate();

  useEffect(() => {
    const timer = setTimeout(() => {
      const hasSeenOnboarding = localStorage.getItem('hasSeenOnboarding');
      const hasCompletedSetup = localStorage.getItem('hasCompletedSetup');
      
      if (!hasSeenOnboarding) {
        navigate('/onboarding');
      } else if (!hasCompletedSetup) {
        navigate('/setup');
      } else {
        navigate('/app');
      }
    }, 1500);

    return () => clearTimeout(timer);
  }, [navigate]);

  return (
    <div className="flex h-screen w-full items-center justify-center bg-surface dark:bg-surface-dark">
      <motion.div
        initial={{ scale: 0.5, opacity: 0 }}
        animate={{ scale: 1, opacity: 1 }}
        transition={{ duration: 0.5, ease: "easeOut" }}
        className="flex flex-col items-center"
      >
        <div className="rounded-full bg-primary p-6 text-white shadow-lg">
          <Dumbbell size={64} />
        </div>
        <motion.h1 
          initial={{ opacity: 0, y: 20 }}
          animate={{ opacity: 1, y: 0 }}
          transition={{ delay: 0.3, duration: 0.5 }}
          className="mt-6 text-3xl font-bold tracking-tight text-gray-900 dark:text-white"
        >
          GymLog Pro
        </motion.h1>
      </motion.div>
    </div>
  );
}
