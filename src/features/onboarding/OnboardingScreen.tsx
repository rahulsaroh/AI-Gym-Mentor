import React, { useState } from 'react';
import { useNavigate } from 'react-router-dom';
import { motion, AnimatePresence } from 'motion/react';
import { Timer, LineChart, BrainCircuit, TableProperties, ChevronRight } from 'lucide-react';
import { cn } from '@/core/utils/cn';

const slides = [
  {
    id: 1,
    title: 'Log in seconds',
    subtitle: 'Fast and intuitive workout logging so you can focus on lifting.',
    icon: Timer,
  },
  {
    id: 2,
    title: 'Track your progress',
    subtitle: 'Visualize your gains with detailed charts and analytics.',
    icon: LineChart,
  },
  {
    id: 3,
    title: 'AI-ready JSON export',
    subtitle: 'Export your data in a structured format ready for AI analysis.',
    icon: BrainCircuit,
  },
  {
    id: 4,
    title: 'Your data, your Google Sheet',
    subtitle: 'Sync seamlessly with Google Sheets for ultimate control.',
    icon: TableProperties,
  },
];

export default function OnboardingScreen() {
  const [currentSlide, setCurrentSlide] = useState(0);
  const navigate = useNavigate();

  const handleNext = () => {
    if (currentSlide < slides.length - 1) {
      setCurrentSlide((prev) => prev + 1);
    } else {
      finishOnboarding();
    }
  };

  const finishOnboarding = () => {
    localStorage.setItem('hasSeenOnboarding', 'true');
    navigate('/setup');
  };

  const SlideIcon = slides[currentSlide].icon;

  return (
    <div className="flex h-screen w-full flex-col bg-surface dark:bg-surface-dark">
      <div className="flex justify-end p-4">
        <button 
          onClick={finishOnboarding}
          className="text-sm font-medium text-gray-500 hover:text-gray-900 dark:text-gray-400 dark:hover:text-white"
        >
          Skip
        </button>
      </div>

      <div className="flex flex-1 flex-col items-center justify-center px-6 text-center">
        <AnimatePresence mode="wait">
          <motion.div
            key={currentSlide}
            initial={{ opacity: 0, x: 20 }}
            animate={{ opacity: 1, x: 0 }}
            exit={{ opacity: 0, x: -20 }}
            transition={{ duration: 0.3 }}
            className="flex flex-col items-center"
          >
            <div className="mb-8 rounded-full bg-primary/10 p-8 text-primary dark:bg-primary/20">
              <SlideIcon size={80} strokeWidth={1.5} />
            </div>
            <h2 className="mb-4 text-3xl font-bold text-gray-900 dark:text-white">
              {slides[currentSlide].title}
            </h2>
            <p className="max-w-xs text-lg text-gray-600 dark:text-gray-300">
              {slides[currentSlide].subtitle}
            </p>
          </motion.div>
        </AnimatePresence>
      </div>

      <div className="flex flex-col items-center pb-12 pt-6 px-6">
        <div className="mb-8 flex space-x-2">
          {slides.map((_, index) => (
            <div
              key={index}
              className={cn(
                "h-2 rounded-full transition-all duration-300",
                index === currentSlide ? "w-8 bg-primary" : "w-2 bg-gray-300 dark:bg-gray-700"
              )}
            />
          ))}
        </div>

        <button
          onClick={handleNext}
          className="flex w-full max-w-sm items-center justify-center rounded-xl bg-primary py-4 text-lg font-semibold text-white shadow-lg transition-transform hover:scale-[1.02] active:scale-[0.98]"
        >
          {currentSlide === slides.length - 1 ? 'Get Started' : 'Next'}
          {currentSlide < slides.length - 1 && <ChevronRight className="ml-2" />}
        </button>
      </div>
    </div>
  );
}
