// pages/api/date-recommendations.ts

import { NextApiRequest, NextApiResponse } from 'next';

const categorys = ['갬카', '먹방', '국내 여행지', '해외 여행지'];

export default (_: NextApiRequest, res: NextApiResponse) => {
  res.status(200).json(categorys);
};
