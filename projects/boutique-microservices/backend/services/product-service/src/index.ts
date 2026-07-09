import express from 'express';
import cors from 'cors';
import helmet from 'helmet';
import * as dotenv from 'dotenv';
import path from 'path';
import { productRoutes } from './routes/products';
import { connectDB } from './database/connection';
import { metricsMiddleware, setupMetrics } from './metrics';

dotenv.config({ path: './.env' });

const app = express();
const PORT = process.env.PORT || 3003;

app.use(helmet());
app.use(cors());
app.use(express.json());

setupMetrics(app, {
  serviceName: 'product-service',
  serviceVersion: '1.0.0'
});

app.use(metricsMiddleware);

// Serve static product images
app.use(
  '/product-images',
  express.static(path.join(__dirname, '../../../public/product-images'))
);

// Product routes
app.use('/products', productRoutes);

// Global error handler
app.use(
  (
    err: any,
    req: express.Request,
    res: express.Response,
    next: express.NextFunction
  ) => {
    console.error(err.stack);
    res.status(500).json({ error: 'Internal server error' });
  }
);

const startServer = async () => {
  try {
    await connectDB();

    app.listen(PORT, () => {
      console.log(`Product service running on port ${PORT}`);
      console.log(`Images available at http://localhost:${PORT}/product-images`);
    });
  } catch (error) {
    console.error('Failed to start product service:', error);
    process.exit(1);
  }
};

startServer();