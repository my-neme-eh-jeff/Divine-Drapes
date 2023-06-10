import { useState, useEffect } from 'react';
import Navbar from '../Navbar/Navbar';
import BulkOrder from '../BulkOrder/BulkOrder';

const HomePage = () => {
  const [showSearchBar, setShowSearchBar] = useState(true);

  useEffect(() => {
    const handleScroll = () => {
      const scrollPosition = window.pageYOffset || document.documentElement.scrollTop;
      const shouldShowSearchBar = scrollPosition === 0;

      setShowSearchBar(shouldShowSearchBar);
    };

    window.addEventListener('scroll', handleScroll);

    return () => {
      window.removeEventListener('scroll', handleScroll);
    };
  }, []);

  return (
    <div>
      {showSearchBar ? (
        <div className="app-bar">
          <Navbar />
          <input type="text" placeholder="Search" />
        </div>
      ) : null}

      <div className="content">
        <BulkOrder/>
      </div>
    </div>
  );
};

export default HomePage;