import { useEffect, useState } from 'react';
import axios from 'axios';
import styles from '../styles/globals.module.css';
import Link from 'next/link';
import Image from 'next/image';

export default function Index() {
  const [categorys, setCategorys] = useState<string[]>([]);
  const [welcome, setWelcome] = useState(false)

  useEffect(() => {
    const fetchData = async () => {
      try {
        const response = await axios.get('/api/dateCategory');
        setCategorys(response.data);
      } catch (error) {
        console.error('데이터 카테고리를 가꼬오지 모태따!', error);
      }
    };

    fetchData();
  }, []);

  function welcomeClick() {
    setWelcome(!welcome)
  }

  return (
    <>
      <div className={styles.container}>
        <h1>오늘 우리 머햄?</h1>
        <ul>
          {categorys.map((category, index) => (
            category === "갬카" ? (
              <Link key={`gamca-${index}`} href="./gamca" style={{ textDecoration: "none", color: "red" }}>
                <li>{category}</li>
              </Link>
            ) : (
              <li key={`other-${index}`}>{category}</li>
            )
          ))}

        </ul>
        <button 
        onClick={welcomeClick}
        className={styles.button}
      >
        반가워요 눌러주세요
      </button>
      <div>
        {welcome ?
          <Image
          src="/photo.png"
          alt="동현이랑 애진이랑 사뽀롱"
          width={600}
          height={550}
        />
        : null
        }
      </div>
      </div>
    </>
  );
}
