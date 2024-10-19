import { Module } from '@nestjs/common';
import { OrderController } from './order.controller';
import { OrderService } from './order.service';
import { AuthModule } from 'src/auth/auth.module';
import { MongooseModule } from '@nestjs/mongoose';
import { Order, OrderSchema } from './schema/order.schema';
import { BookModule } from 'src/book/book.module';

@Module({
  imports:[
    AuthModule,
    BookModule,
    MongooseModule.forFeature([{ name: Order.name, schema: OrderSchema }]),
 
  ],
  controllers: [OrderController],
  providers: [OrderService]
})
export class OrderModule {}
