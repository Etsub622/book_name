/* eslint-disable prettier/prettier */
import { Module } from '@nestjs/common';
import { BookModule } from './book/book.module';
import { ConfigModule } from '@nestjs/config';
import { MongooseModule } from '@nestjs/mongoose';
import { AuthModule } from './auth/auth.module';
import { OrderModule } from './order/order.module';
import * as dotenv from 'dotenv';

dotenv.config();



@Module({
  imports: [
    ConfigModule.forRoot({
      envFilePath: '.env',
      isGlobal: true,
    }),
    MongooseModule.forRoot(process.env.DB_URI),
    BookModule,
    AuthModule,
    OrderModule,
    
  ],
  controllers: [],
  providers: [],
})
export class AppModule {}

